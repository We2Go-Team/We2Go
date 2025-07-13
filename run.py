from app import create_app
from app.dao import auth_user

app = create_app()

if __name__ == '__main__':
    auth_user("user1", "password")
    auth_user("user2", "password")
    auth_user("user3", "password")
    app.run(debug=True)

