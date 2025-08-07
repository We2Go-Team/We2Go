from flask import Blueprint, request, redirect, render_template, flash, url_for
import os, json, re, unicodedata
from datetime import datetime
from app.services import EventService



events = Blueprint('events', __name__, url_prefix='/events')


def slugify(text):
    text = text.replace('đ', 'd').replace('Đ', 'd')
    text = unicodedata.normalize('NFD', text)
    text = text.encode('ascii', 'ignore').decode('utf-8')
    text = re.sub(r'[^\w\s-]', '', text).lower()
    text = re.sub(r'[\s_-]+', '-', text).strip('-')
    return text
def parse_vietnamese_event_time(time_str):
    try:
        # Định dạng 1: "20:00 - 23:00, 25 tháng 07, 2025"
        if " - " in time_str and ", " in time_str:
            # Check nếu có 2 phần thời gian và 1 ngày duy nhất
            parts = time_str.split(", ")
            if len(parts) == 2:
                time_range, date_str = parts
                start_time, _ = time_range.split(" - ")
                day, _, month, year = date_str.replace("tháng", "").strip().split()
                full_datetime_str = f"{year}-{int(month):02d}-{int(day):02d} {start_time}"
                return datetime.strptime(full_datetime_str, "%Y-%m-%d %H:%M")
        
        # Định dạng 2: "10:00, 24 tháng 07, 2025 - 20:00, 27 tháng 07, 2025"
        elif " - " in time_str:
            start_str, _ = time_str.split(" - ")
            time_part, date_part = start_str.strip().split(", ")
            day, _, month, year = date_part.replace("tháng", "").strip().split()
            full_datetime_str = f"{year}-{int(month):02d}-{int(day):02d} {time_part.strip()}"
            return datetime.strptime(full_datetime_str, "%Y-%m-%d %H:%M")

    except Exception as e:
        print(f"Lỗi khi parse '{time_str}': {e}")
        return None

@events.route('/', methods=['GET', 'POST']) 
def events_page():
    events = EventService.get_all_events()
    events_dict = []    
    for e in events:
        if isinstance(e.time_start, datetime):
            date_str = e.time_start
        else:
            date_str = ""
            
        status_str = getattr(e.status, "value", e.status) or "Draft"
        min_price = e.min_price if e.min_price is not None else 0
        events_dict.append({
            "id": str(e.id),
            "title": e.title or "No title",
            "description": e.description or "",
            "location": e.location or "",
            "date": date_str,
            "status": status_str,
            "min_price": min_price,
            "images": e.images
        })

    # Sắp xếp theo ngày, đưa những event không có ngày xuống cuối
    events_sorted = sorted(
        events_dict,
        key=lambda x: parse_vietnamese_event_time(x["date"]) or datetime.max
    )

    return render_template("pages/events.html", show_header=True, events=events_sorted)

@events.route('/<alias>', methods=['GET'])
def events_detail_page(alias):
    event = EventService.get_event_by_alias(slugify(alias)) 
    return render_template('pages/event_detail.html', show_header=True, event=event)

@events.route('/search', methods=['GET', 'POST'])
def events_search_page():
    # Lấy các tham số từ form hoặc query string
    method = request.method
    get_value = lambda key: (request.args if method == 'GET' else request.form).get(key, '').strip().lower()
    keyword = get_value('q')
    location = get_value('location')
    price_range = get_value('price')  # 'under_1m', 'over_1m'
    category = get_value('category')

    events = EventService.search_events(
        keyword=keyword,
        location=location,
        price_range=price_range,
        category=category
    )
   
    return render_template('pages/events.html', show_header=True, events=events)

