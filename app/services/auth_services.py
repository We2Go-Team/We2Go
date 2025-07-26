from werkzeug.security import generate_password_hash, check_password_hash
from app.models.user import User
from app.repositories import user_repository
from app.validators.user_validator import validate_user_register_data

def register(data: dict):
    # validate data
    validate_user_register_data(data)

    hashed_password = generate_password_hash(data.get("password"))
    user = User(
        first_name=data.get("first_name", ""),
        last_name=data.get("last_name", ""),
        email=data.get("email", ""),
        password=hashed_password,
        avatar=data.get("avatar", ""),
        phone=data.get("phone", ""),
        role=data.get("role", "USER")
    )
    return user_repository.create_user(user)

def login(data: dict):
    email = data.get("email")
    password = data.get("password")
    user = user_repository.get_user_by_email(email)
    if not user or not check_password_hash(user.password, password):
        raise ValueError("Invalid email or password.")
    return user
