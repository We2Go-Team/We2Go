# app/services/zone_service.py

from app.models.zone import Zone
from app.repositories.zone_repository import ZoneRepository


class ZoneService:
    @staticmethod
    def create_zone(zone: Zone):
        return ZoneRepository.create_zone(zone)

    @staticmethod
    def get_all_zones():
        return ZoneRepository.get_all_zones()

    @staticmethod
    def get_zone_by_id(zone_id):
        return ZoneRepository.get_zone_by_id(zone_id)

    @staticmethod
    def get_zones_by_event(event_id):
        return ZoneRepository.get_zones_by_event(event_id)

    @staticmethod
    def get_zone_by_name(event_id, name):
        return ZoneRepository.get_zone_by_name(event_id, name)

    @staticmethod
    def update_zone(zone_id, data: dict):
        return ZoneRepository.update_zone(zone_id, **data)

    @staticmethod
    def delete_zone(zone_id):
        return ZoneRepository.delete_zone(zone_id)

    @staticmethod
    def search_zones(event_id=None, zone_type=None, keyword=None):
        return ZoneRepository.search_zones(event_id, zone_type, keyword)
