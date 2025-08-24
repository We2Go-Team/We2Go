from flask import Blueprint, render_template
import json
import os

home = Blueprint('home', __name__)

@home.route('/')
def home_page():
    
    # Mở file JSON
    data_path = os.path.join(os.path.dirname(__file__), '..', 'static', 'data', 'data.json')
    with open(data_path, 'r', encoding='utf-8') as f:
        events = json.load(f)

    return render_template('pages/user/home.html', show_header=True, trending_events=events)