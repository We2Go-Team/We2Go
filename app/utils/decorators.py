from functools import wraps
from flask import flash, redirect, url_for, request, jsonify


def catch_errors(redirect_on_error=None):
    def decorator(func):
        @wraps(func)
        def wrapper(*args, **kwargs):
            try:
                return func(*args, **kwargs)
            except ValueError as e:
                error_msg = str(e)
            except AttributeError:
                error_msg = "Invalid form data."
            except Exception:
                error_msg = "Unexpected error."
                
            if request.accept_mimetypes['application/json'] >= request.accept_mimetypes['text/html']:
                return jsonify({ "success": False, "data": None ,"message": error_msg }), 400

            # Nếu là form HTML SSR → flash lỗi + redirect hoặc render lại
            # flash(error_msg, "danger")
            # if redirect_on_error:
            #     return redirect(url_for(redirect_on_error))
            # return None 
        return wrapper
    return decorator