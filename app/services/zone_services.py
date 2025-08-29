# app/services/zone_service.py

from app.models.zone import Zone
from app.repositories.zone_repository import ZoneRepository
import string

class ZoneService:
    @staticmethod
    def create_default_zone_for_event(event_id):
        """Tạo một zone mặc định với tên theo alphabet (Zone A, Zone B, ...)"""

        # Lấy tất cả zone hiện tại của event
        existing_zones = ZoneRepository.get_zones_by_event(event_id)
        existing_names = [z.name for z in existing_zones]

        # Sinh tên theo alphabet: Zone A, Zone B, Zone C...
        for letter in string.ascii_uppercase:
            candidate_name = f"Zone {letter}"
            if candidate_name not in existing_names:
                new_zone = Zone(
                    event_id=event_id,
                    name=candidate_name,
                    type="STANDING",  # hoặc default khác
                    capacity=0,
                    price=0.0,
                )
                created_zone = ZoneRepository.create_zone(new_zone)

                # Trả về dict để render dễ dàng
                return {
                    "id": str(created_zone.id),
                    "event_id": str(created_zone.event_id),
                    "name": created_zone.name,
                    "type": created_zone.type,
                    "capacity": created_zone.capacity,
                    "price": created_zone.price,
                }

        # Nếu vượt quá Z thì có thể đặt theo số
        raise Exception("Đã hết alphabet cho Zone!")

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
