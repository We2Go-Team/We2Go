from flask import Blueprint, request, redirect, render_template, flash, url_for, session
from app.services import AuthService
from app.utils.decorators import catch_errors



auth = Blueprint('auth', __name__)

@auth.route('/register', methods=['GET', 'POST'])
def register():
    if request.method == 'POST':
        formData = request.form.to_dict()
        AuthService.register(formData)
        flash("Đăng kí thành công!", "success")
        return redirect(url_for('auth.login'))
    return render_template('pages/user/register.html')


@auth.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        # Lấy dữ liệu form
        form_data = request.form.to_dict()

        # Gọi service xử lý đăng nhập
        user = AuthService.login(form_data)

        if user:
            # Lưu user vào session
            session["user_id"] = user.id
            session["user_email"] = user.email
            session["user_name"] = user.first_name + user.last_name

            
            flash("Đăng nhập thành công!", "success")
            return redirect(url_for('home.home_page'))
        else:
            flash("Sai email hoặc mật khẩu!", "danger")
            return render_template('pages/user/login.html', show_header=False)

    # Nếu là GET thì render form login
    return render_template('pages/user/login.html', show_header=False)
