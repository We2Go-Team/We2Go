from flask import Blueprint, request, redirect, render_template, flash, url_for
from app.services import auth_services
from app.utils.decorators import catch_errors

auth = Blueprint('auth', __name__)

@auth.route('/register', methods=['GET', 'POST'])
@catch_errors()
def register():
    if request.method == 'POST':
        formData = request.get_json() # Get data from body request
        auth_services.register(formData)
        return redirect(url_for('auth.login'))
    return render_template('pages/register.html')

@auth.route('/login', methods=['GET', 'POST'])
@catch_errors()
def login():
    if request.method == 'POST':
        formData = request.get_json() # Get data from body request
        auth_services.login(formData)
        return render_template('pages/home.html')
    else :
        return render_template('pages/login.html', show_header=False)