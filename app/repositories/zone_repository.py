# app/repositories/zone_repository.py

from app.models.zone import Zone
from app.config.database import db
from sqlalchemy import func


class ZoneRepository:
    @staticmethod
    def create_zone(zone: Zone):
        """Thêm một zone mới"""
        db.session.add(zone)
        db.session.commit()
        return zone

    @staticmethod
    def get_all_zones():
        """Lấy tất cả zone"""
        return Zone.query.all()

    @staticmethod
    def get_zone_by_id(zone_id):
        """Lấy zone theo id"""
        return Zone.query.get(zone_id)

    @staticmethod
    def get_zones_by_event(event_id):
        """Lấy tất cả zone thuộc một event"""
        return Zone.query.filter(Zone.event_id == event_id).all()

    @staticmethod
    def get_zone_by_name(event_id, name):
        """Lấy zone theo tên trong một event"""
        return Zone.query.filter(
            func.lower(Zone.name) == name.lower(),
            Zone.event_id == event_id
        ).first()

    @staticmethod
    def update_zone(zone_id, **kwargs):
        """Cập nhật thông tin zone"""
        zone = ZoneRepository.get_zone_by_id(zone_id)
        if zone:
            for key, value in kwargs.items():
                if hasattr(zone, key):
                    setattr(zone, key, value)
            db.session.commit()
            return zone
        return None

    @staticmethod
    def delete_zone(zone_id):
        """Xóa zone"""
        zone = ZoneRepository.get_zone_by_id(zone_id)
        if zone:
            db.session.delete(zone)
            db.session.commit()
            return True
        return False

    @staticmethod
    def search_zones(event_id=None, zone_type=None, keyword=None):
        """Tìm kiếm zone theo event, type, hoặc từ khóa"""
        query = Zone.query

        if event_id:
            query = query.filter(Zone.event_id == event_id)

        if zone_type:
            query = query.filter(Zone.type == zone_type)

        if keyword:
            query = query.filter(Zone.name.ilike(f"%{keyword}%"))

        return query.order_by(Zone.name.asc()).all()
