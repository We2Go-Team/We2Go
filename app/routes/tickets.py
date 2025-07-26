from flask import Blueprint, request, redirect, render_template, flash, url_for
import os, json, re, unicodedata
from datetime import datetime

tickets = Blueprint('tickets', __name__, url_prefix='/tickets')


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

@tickets.route('/', methods=['GET', 'POST']) 
def tickets_page():
    data_path = os.path.join(os.path.dirname(__file__), '..', 'static', 'data', 'data.json')
    with open(data_path, 'r', encoding='utf-8') as f:
        tickets = json.load(f)

    tickets_sorted = sorted(tickets, key=lambda x: parse_vietnamese_event_time(x["date"]) or datetime.max)
    return render_template('pages/tickets.html', show_header=True, tickets=tickets_sorted)

@tickets.route('/<alias>', methods=['GET'])
def ticket_detail_page(alias):
    data_path = os.path.join(os.path.dirname(__file__), '..', 'static', 'data', 'data.json')
    with open(data_path, 'r', encoding='utf-8') as f:
        tickets = json.load(f)
    ticket = next((p for p in tickets if slugify(p['name']) == alias), None)

    return render_template('pages/ticket_detail.html', show_header=True, ticket=ticket)


@tickets.route('/search', methods=['GET', 'POST'])
def tickets_search_page():


    data_path = os.path.join(os.path.dirname(__file__), '..', 'static', 'data', 'data.json')
    with open(data_path, 'r', encoding='utf-8') as f:
        tickets = json.load(f)

    # Lấy các tham số từ form hoặc query string
    method = request.method
    get_value = lambda key: (request.args if method == 'GET' else request.form).get(key, '').strip().lower()
    keyword = get_value('q')
    location = get_value('location')
    price_range = get_value('price')  # 'under_1m', 'over_1m'
    category = get_value('category')

    # Lọc theo từ khóa
    if keyword:
        tickets = [t for t in tickets if keyword in t.get('name', '').lower()]

    # Lọc theo địa điểm tổ chức
    if location and location != 'toàn quốc':
        tickets = [t for t in tickets if location.lower() in t.get('location', {}).get('address', '').lower()]

    # Lọc theo giá tiền
    if price_range:
        def price_filter(t):
            price = t.get('price', 0)
            if price_range == 'under_1m':
                return price < 1000000
            elif price_range == 'over_1m':
                return price >= 1000000
            return True
        tickets = [t for t in tickets if price_filter(t)]

    # Lọc theo thể loại
    if category:
        tickets = [t for t in tickets if category in t.get('type', '').lower()]

    # Sắp xếp thời gian
    tickets_sorted = sorted(tickets, key=lambda x: parse_vietnamese_event_time(x.get("date", "")) or datetime.max)

    

    return render_template('pages/tickets.html', show_header=True, tickets=tickets_sorted)

