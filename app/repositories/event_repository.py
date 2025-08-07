from app.models.event import Event
from app.models.category import Category
from app.config.database import db
from sqlalchemy import func, or_
from sqlalchemy.orm import joinedload

class EventRepository:
    @staticmethod
    def create_event(event: Event):
        db.session.add(event)
        db.session.commit()
        return event

    @staticmethod
    def get_all_events():
        return Event.query.all()

    @staticmethod
    def get_event_by_id(event_id):
        return Event.query.get(event_id)

    @staticmethod
    def get_event_by_alias(alias):
        return Event.query.filter(func.lower(Event.alias) == alias.lower()).first()

    @staticmethod
    def get_event_by_location(location):
        return Event.query.filter(func.lower(Event.location) == location.lower()).all()

    @staticmethod
    def delete_event(event_id):
        event = get_event_by_id(event_id)
        if event:
            db.session.delete(event)
            db.session.commit()
            return True
        return False

    @staticmethod
    def update_event(event_id, **kwargs):
        event = get_event_by_id(event_id)
        if event:
            for key, value in kwargs.items():
                if hasattr(event, key):
                    setattr(event, key, value)
            db.session.commit()
            return event
        return None

    @staticmethod
    def search(keyword=None, location=None, price_range=None, category=None):
        query = Event.query
        # Lọc theo từ khóa (title)
        if keyword:
            query = query.filter(Event.title.ilike(f"%{keyword}%"))

        # Lọc theo địa điểm hoặc venue (nếu không phải "toàn quốc")
        if location and location.lower() != "toàn quốc":
            query = query.filter(
                or_(
                    Event.location.ilike(f"%{location}%"),
                    # Event.venue.ilike(f"%{location}%")
                )
            )

        # Lọc theo giá tiền nếu không phải "all"
        if price_range and price_range != "all":
            if price_range == "under_1m":
                query = query.filter(Event.min_price < 1_000_000)
            elif price_range == "over_1m":
                query = query.filter(Event.min_price >= 1_000_000)

        # Lọc theo thể loại nếu không phải "all"
        if category and category != "all":
            query = query.join(Event.categories).filter(Category.name.ilike(f"%{category}%"))

        return query.options(joinedload(Event.categories)).order_by(Event.time_start.asc()).all()
