class UserRegisterDTO:
    REQUIRED_FIELDS = ["email", "password", "first_name", "last_name"]

    def __init__(self, data):
        missing = [f for f in self.REQUIRED_FIELDS if not data.get(f)]
        if missing:
            raise ValueError(f"Missing fields: {', '.join(missing)}")
        self.data = data

    def to_dict(self):
        return self.data