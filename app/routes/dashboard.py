from flask import Blueprint, render_template
from app.services import EventService
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

        # === Handle image upload ===
        image_url = None
        if "images" in request.files:
            file = request.files["images"]
            if file and file.filename != "":
                upload_result = cloudinary.uploader.upload(
                    file,
                    folder="We2Go Upload"
                )
                image_url = upload_result["secure_url"]

        # === Convert date + time to datetime objects ===
        time_start = None
        time_end = None
        if start_date and start_time:
            time_start = datetime.strptime(f"{start_date} {start_time}", "%Y-%m-%d %H:%M")
        if end_date and end_time:
            time_end = datetime.strptime(f"{end_date} {end_time}", "%Y-%m-%d %H:%M")

        # === Build data dict ===
        data = {
            "title": title,
            "alias": alias,
            "description": description,
            "organizer_id": None,  # TODO: lấy từ session login
            "time_start": time_start,
            "time_end": time_end,
            "venue": venue,
            "location": location,
            "images": image_url,
            "min_price": float(request.form.get("min_price") or 0),
            "status": "UPCOMING",  
        }
        
        
        print(data)

        # === Create event ===
        EventService.create_event(data)
        flash("Sự kiện đã được tạo!", "success")
        # === Always return a response ===
        return render_template(
            "pages/dashboard/event_form.html",
            title="Tạo sự kiện mới",
            event=None,
            success_msg="Sự kiện đã được tạo thành công!"
        )

    # === GET request ===
    return render_template(
        "pages/dashboard/event_form.html",
        title="Tạo sự kiện mới",
        event=None
    )

# Trang quản lý sự kiện
# @dashboard.route('/dashboard/events')
# def events_page():
#     return render_template('pages/dashboard/events.html', show_header=False)
