from flask import Blueprint, request, redirect, render_template, flash, url_for
from app.services import auth_services
from app.utils.decorators import catch_errors
from app.DTOs import UserRegisterDTO
auth = Blueprint('auth', __name__)

@auth.route('/register', methods=['GET', 'POST'])
@catch_errors()
def register():
    if request.method == 'POST':
        formData = request.get_json() # Get data from body request
        # Validate bằng DTO
        dto = UserRegisterDTO(formData)
        auth_services.register(dto.to_dict())
        return redirect(url_for('auth.login'), 200, None)
    return render_template('pages/register.html')

@auth.route('/login', methods=['GET', 'POST'])
@catch_errors()
def login():
    if request.method == 'POST':
        formData = request.get_json() # Get data from body request
        auth_services.login(formData)
        return render_template('pages/home.html')
    else :
        return render_template('pages/login.html', show_header=False, show_footer=False)