import re
from app.repositories import user_repository


EMAIL_REGEX = re.compile(r"[^@]+@[^@]+\.[^@]+")
PHONE_REGEX = re.compile(r"^\d{9,15}$")


def validate_user_register_data(data: dict):
    required_fields = ["email", "phone", "first_name", "last_name", "password"]
    for field in required_fields:
        value = data.get(field)
        if not value or str(value).strip() == "":
            raise ValueError(f"{field.replace('_', ' ').title()} is required.")

    email = data["email"]
    phone = data["phone"]
    password = data["password"]

    # --- Email format ---
    if not EMAIL_REGEX.match(email):
        raise ValueError("Invalid email format.")
    
    # --- Password ---
    if len(password) < 8:
        raise ValueError("Password must be at least 8 characters.")
    
    # --- Phone format ---
    if not PHONE_REGEX.match(phone):
        raise ValueError("Phone number must be 9–15 digits.")

    # --- Uniqueness ---
    if user_repository.get_user_by_email(email):
        raise ValueError("Email already registered.")
    
    if user_repository.get_user_by_phone(phone):
        raise ValueError("Phone number already registered.")
