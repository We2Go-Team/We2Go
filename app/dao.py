import json

path = "app/data/user.json"

def auth_user(username, password) -> bool:
    with open(path) as f:
        data = json.load(f)
        for user in data["users"]:
            if user["username"] == username and user["password"] == password:
                print("Auth success")
                return True
    print("Auth failure")
    return False
