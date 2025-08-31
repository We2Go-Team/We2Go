from functools import wraps
from flask import flash, redirect, url_for, request, jsonify, render_template
import base64
from werkzeug.datastructures import FileStorage
import io
import cloudinary
import cloudinary.uploader


def catch_errors():
    def decorator(func):
        @wraps(func)
        def wrapper(*args, **kwargs):
            try:
                return func(*args, **kwargs)
            except ValueError as e:
                error_msg = str(e)
            except AttributeError:
                error_msg = "Invalid form data."
            except Exception as e:
                error_msg = f"Unexpected error: {str(e)}"

            # # Lấy form_data để route fill lại form
            # form_data = request.form.to_dict()

            # # Nếu client muốn JSON
            # if request.headers.get("X-Requested-With") == "XMLHttpRequest":
            #     return jsonify({"success": False, "data": form_data, "error_msg": error_msg}), 400

            # # Nếu HTML → trả về dict cho route handle render template
            # return {"error_msg": error_msg, "form_data": form_data}

        return wrapper
    return decorator

def validate_dto_fields(dto_class, template, context_extra=None):
    """
    Decorator validate POST data dựa trên DTO (EventCreateDTO).
    
    - dto_class: class DTO (phải raise ValueError nếu thiếu field)
    - template: template render lại khi có lỗi
    - context_extra: dict thêm context tùy ý
    """
    def decorator(func):
        @wraps(func)
        def wrapper(*args, **kwargs):
            if request.method == "POST":
                data_source = request.form.to_dict() if not request.is_json else request.json

                if "images" in request.files:
                    file = request.files["images"]
                    if file and file.filename != "":
                        upload_result = cloudinary.uploader.upload(file, folder="We2Go Upload")
                        image_url = upload_result["secure_url"]
                        data_source["images"] = image_url
                    
                # Chuyển description nếu dùng CKEditor
                if "ckeditor" in data_source:
                    data_source["description"] = data_source["ckeditor"]
                try:
                    # Tạo instance DTO (DTO sẽ tự validate tất cả field, bao gồm start/end date/time)
                    dto_instance = dto_class(data_source)
                except ValueError as e:
                    # Lấy danh sách các field bị thiếu từ message
                    msg = str(e)
                    missing_fields = []
                    if msg.startswith("Missing fields:"):
                        missing_fields = [f.strip() for f in msg.replace("Missing fields:", "").split(",")]

                    context = {
                        "form_data": data_source,
                        "error_msg": msg,
                        "missing_fields": missing_fields
                    }
                            
                    flash(" vui lòng kiểm tra và cung cấp đầy đủ thông tin yêu cầu", "danger")
                    
                    if context_extra:
                        context.update(context_extra)
                        
                    return redirect(url_for(template, **context))

                # Nếu hợp lệ, gán dto_instance vào kwargs để route sử dụng
                kwargs["dto_class"] = dto_instance

            return func(*args, **kwargs)
        return wrapper
    return decorator