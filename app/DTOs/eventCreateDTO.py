from datetime import datetime

class EventCreateDTO:
    REQUIRED_FIELDS = ["title", "alias", "time_start", "time_end", "venue", "location", "description"]

    def __init__(self, data: dict):
        # Kiểm tra từng field bắt buộc, bao gồm start_date/start_time, end_date/end_time
        missing = []

        # Các field thông thường
        for f in ["title", "alias", "venue", "location", "description"]:
            if not data.get(f) or str(data.get(f)).strip() == "":
                missing.append(f)

        # Kiểm tra start_date/start_time
        if not data.get("start_date"):
            missing.append("start_date")
        if not data.get("start_time"):
            missing.append("start_time")

        # Kiểm tra end_date/end_time
        if not data.get("end_date"):
            missing.append("end_date")
        if not data.get("end_time"):
            missing.append("end_time")

        if missing:
            raise ValueError(f"Missing fields: {', '.join(missing)}")

        # Gộp datetime
        try:
            data["time_start"] = datetime.fromisoformat(f"{data['start_date']}T{data['start_time']}")
            data["time_end"] = datetime.fromisoformat(f"{data['end_date']}T{data['end_time']}")
        except ValueError:
            raise ValueError("Invalid datetime format for start or end. Use ISO format YYYY-MM-DDTHH:MM")

        # Gán các thuộc tính
        self.title = data["title"]
        self.alias = data["alias"]
        self.time_start = data["time_start"]
        self.time_end = data["time_end"]
        self.venue = data["venue"]
        self.location = data["location"]
        self.description = data["description"]

    def to_dict(self):
        return {
            "title": self.title,
            "alias": self.alias,
            "time_start": self.time_start.isoformat(),
            "time_end": self.time_end.isoformat(),
            "venue": self.venue,
            "location": self.location,
            "description": self.description
        }
