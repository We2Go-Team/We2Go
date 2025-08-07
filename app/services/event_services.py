# app/services/event_service.py

from app.models.event import Event, EventStatus
from app.repositories.event_repository import EventRepository


class EventService:
    @staticmethod
    def get_all_events():
        return EventRepository.get_all_events()

    @staticmethod
    def get_event_by_alias(alias: str):
        return EventRepository.get_event_by_alias(alias)

    @staticmethod
    def get_event_by_id(event_id):
        return EventRepository.get_event_by_id(event_id)

    @staticmethod
    def update_event(event_id, data: dict):
        return EventRepository.update_event(event_id, **data)

    @staticmethod
    def delete_event(event_id):
        return EventRepository.delete_event(event_id)

    @staticmethod
    def publish_event(event_id):
        return EventRepository.update_event(event_id, status=EventStatus.PUBLISHED)

    @staticmethod
    def cancel_event(event_id):
        return EventRepository.update_event(event_id, status=EventStatus.CANCELLED)

    @staticmethod
    def search_events(keyword=None, location=None, price_range=None, category=None):
        return EventRepository.search(keyword, location, price_range, category)
