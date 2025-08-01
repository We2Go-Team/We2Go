from functools import wraps
from flask import request, jsonify
from sqlalchemy.exc import IntegrityError
from app.config.database import db
import traceback

def catch_errors(redirect_on_error=None):
    def decorator(func):
        @wraps(func)
        def wrapper(*args, **kwargs):
            try:
                return func(*args, **kwargs)

            except ValueError as e:
                error_msg = str(e)
                status_code = 400

            except AttributeError:
                error_msg = "Invalid form data."
                status_code = 400

            except IntegrityError:
                db.session.rollback()
                error_msg = "Duplicate entry in database."
                status_code = 400

            except Exception as e:
                # Log chi tiết cho dev
                traceback.print_exc()
                error_msg = "Internal server error."
                status_code = 500

            # Trả JSON nếu client chấp nhận JSON
            if request.accept_mimetypes['application/json'] >= request.accept_mimetypes['text/html']:
                return jsonify({
                    "success": False,
                    "data": None,
                    "message": error_msg
                }), status_code

            # Nếu muốn hỗ trợ HTML form:
            # flash(error_msg, "danger")
            # if redirect_on_error:
            #     return redirect(url_for(redirect_on_error))
            # return render_template("error.html", message=error_msg), status_code

        return wrapper
    return decorator
