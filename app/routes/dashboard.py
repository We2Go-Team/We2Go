from flask import Blueprint, render_template, jsonify
from app.services import EventService, ZoneService
import os, json, re, unicodedata
from flask import Blueprint, request, redirect, render_template, flash, url_for
from datetime import datetime
from flask_ckeditor import CKEditor
import cloudinary
import cloudinary.uploader
from app.utils.decorators import catch_errors, validate_dto_fields
from app.DTOs.eventCreateDTO import EventCreateDTO



dashboard = Blueprint("dashboard", __name__)

def slugify(text):
    text = text.replace("đ", "d").replace("Đ", "d")
    text = unicodedata.normalize("NFD", text)
    text = text.encode("ascii", "ignore").decode("utf-8")
    text = re.sub(r"[^\w\s-]", "", text).lower()
    text = re.sub(r"[\s_-]+", "-", text).strip("-")
    return text


# Trang tổng quan
@dashboard.route("/dashboard")
def overview_page():
    return render_template("pages/dashboard/overview.html", show_header=False)


# Trang quản lý vé và sự kiện
@dashboard.route("/dashboard/events")
def events_page():
    headers = [
        {"label": "Sự kiện", "class": "label-name tbl-col-20", "field": "event"},
        {"label": "Ngày diễn ra", "class": "label-date tbl-col-15", "field": "date"},
        {
            "label": "Địa điểm",
            "class": "label-location tbl-col-30",
            "field": "location",
        },
        {"label": "Trạng thái", "class": "label-status tbl-col-10", "field": "status"},
        {"label": "Đã bán", "class": "label-sold", "field": "sold"},
    ]
    events = EventService.get_all_events()
    data = []
    for e in events:
        item = {
            "id": e.id,
            "alias": e.alias,
            "event": {
                "name": e.title,
                "type": (
                    ", ".join([c.name for c in e.categories]) if e.categories else None
                ),
            },
            "date": (
                e.time_start.strftime("%Y-%m-%d %H:%M:%S") if e.time_start else None
            ),
            "location": {"venue": e.venue, "address": e.location},
            "status": e.status.value if hasattr(e.status, "value") else str(e.status),
            "sold": f"{e.tickets_sold} vé" if hasattr(e, "tickets_sold") else "0 vé",
        }
        data.append(item)

    return render_template(
        "pages/dashboard/events_management.html",
        show_header=False,
        headers=headers,
        events=data,
    )


@dashboard.route("/dashboard/events/<alias>", methods=["GET"])
def event_detail_page(alias):
    event = EventService.get_event_by_alias(alias)
    print(event)
    return render_template(
        "pages/dashboard/event_detail_management.html", show_header=False, event=event
    )


@dashboard.route("/dashboard/event/new", methods=["GET", "POST"])
@validate_dto_fields(EventCreateDTO, template="pages/dashboard/event_form.html")
def create_event(dto_class=None):
    global next_id

    if request.method == "POST":

        # === Get form data ===
        title = request.form.get("title")
        alias = request.form.get("alias")
        start_date = request.form.get("start_date")
        start_time = request.form.get("start_time")
        end_date = request.form.get("end_date")
        end_time = request.form.get("end_time")
        venue = request.form.get("venue")
        location = request.form.get("location")
        description = request.form.get("ckeditor")  # HTML
        images = request.form.get("images")  # HTML
        
        
        # === Handle image upload ===
        image_url = None
        if images != "":
            image_url = images

        if "images" in request.files:
            file = request.files["images"]
            if file and file.filename != "":
                file.stream.seek(0)
                upload_result = cloudinary.uploader.upload(file, folder="We2Go Upload")
                image_url = upload_result["secure_url"]
            else:
                # Không upload gì, giữ file cũ hoặc Base64 tạm
                pass
        # === Convert date + time to datetime objects ===
        time_start = None
        time_end = None
        if start_date and start_time:
            time_start = datetime.strptime(
                f"{start_date} {start_time}", "%Y-%m-%d %H:%M"
            )
        if end_date and end_time:
            time_end = datetime.strptime(f"{end_date} {end_time}", "%Y-%m-%d %H:%M")

        # === Build data dict ===
        data = {
            "title": title,
            "alias": alias,
            "description": description,
            "organizer_id": None,  # TODO: lấy từ session login
            "start_date": start_date,
            "end_date": end_date,
            "start_time": start_time,
            "end_time": end_time,
            "time_start": time_start,
            "time_end": time_end,
            "venue": venue,
            "location": location,
            "images": image_url,
            "min_price": float(request.form.get("min_price") or 0),
            "status": "UPCOMING",
        }
        
        # === Create event ===
        created_event = EventService.create_event(data)
        flash("Sự kiện đã được tạo!", "success")

        return  redirect(url_for('dashboard.preview_event', alias=created_event.alias))

    # === GET request ===
    return render_template(
        "pages/dashboard/event_form.html", title="Tạo sự kiện mới", event=None
    )


@dashboard.route("/dashboard/event/preview/<alias>", methods=["GET", "POST"])
@validate_dto_fields(EventCreateDTO, template="pages/dashboard/event_form.html")
def preview_event(alias, dto_class=None):
    # Lấy event từ service theo alias
    event = EventService.get_event_by_alias(alias)
    zones = ZoneService.get_zones_by_event(event.id)
    if request.method == "POST":
        # === Lấy dữ liệu từ form ===
        title = request.form.get("title")
        alias = request.form.get("alias")
        start_date = request.form.get("start_date")
        start_time = request.form.get("start_time")
        end_date = request.form.get("end_date")
        end_time = request.form.get("end_time")
        venue = request.form.get("venue")
        location = request.form.get("location")
        description = request.form.get("ckeditor")  # HTML
        images = request.form.get("images")  # HTML

        # === Handle image upload ===
        image_url = images if images else event.images if event else None
        if "images" in request.files:
            file = request.files["images"]
            if file and file.filename != "":
                file.stream.seek(0)
                upload_result = cloudinary.uploader.upload(file, folder="We2Go Upload")
                image_url = upload_result["secure_url"]

        # === Convert date + time ===
        time_start = (
            datetime.strptime(f"{start_date} {start_time}", "%Y-%m-%d %H:%M")
            if start_date and start_time
            else None
        )
        time_end = (
            datetime.strptime(f"{end_date} {end_time}", "%Y-%m-%d %H:%M")
            if end_date and end_time
            else None
        )

        # === Build data dict ===
        data = {
            "title": title,
            "alias": alias,
            "description": description,
            "organizer_id": event.organizer_id if event else None,
            "start_date": start_date,
            "end_date": end_date,
            "start_time": start_time,
            "end_time": end_time,
            "time_start": time_start,
            "time_end": time_end,
            "venue": venue,
            "location": location,
            "images": image_url,
            "min_price": float(request.form.get("min_price") or 0),
            "status": "UPCOMING",
        }

        # === Create hoặc update event ===
        if event:
            updated_event = EventService.update_event(event.id, data)
            flash("Sự kiện đã được cập nhật!", "success")
            event_obj = updated_event
        else:
            created_event = EventService.create_event(data)
            flash("Sự kiện đã được tạo!", "success")
            event_obj = created_event
            
        return redirect(url_for('dashboard.preview_event', alias=updated_event.alias))
       
    time_start = event.time_start
    time_end = event.time_end

    # Tách ra ngày và giờ
    start_date = time_start.strftime("%Y-%m-%d") if time_start else ""
    start_time = time_start.strftime("%H:%M") if time_start else ""

    end_date = time_end.strftime("%Y-%m-%d") if time_end else ""
    end_time = time_end.strftime("%H:%M") if time_end else ""
    # === GET request: render form với dữ liệu event ===
    event_data = (
        {
            "title": event.title,
            "alias": event.alias,
            "start_date": start_date,
            "start_time": start_time,
            "end_date": end_date,
            "end_time": end_time,
            "venue": event.venue,
            "location": event.location,
            "description": event.description,
            "images": event.images,
            "min_price": event.min_price,
            "status": event.status,
        }
        if event
        else {}
    )


    zones_data = [z.to_dict() for z in zones] if zones else []
    return render_template(
        "pages/dashboard/event_form.html",
        title="Xem / Cập nhật sự kiện",
        event=event_data,
        event_id=event.id if event else None,
        zones=zones_data
    )


