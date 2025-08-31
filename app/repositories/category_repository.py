# app/repositories/category_repository.py
from app.models.category import Category
from app.config.database import db
from sqlalchemy.exc import SQLAlchemyError
from sqlalchemy.orm import joinedload
from sqlalchemy import func

class CategoryRepository:

    @staticmethod
    def create_category(category: Category):
        """Tạo mới category từ instance Category"""
        try:
            db.session.add(category)
            db.session.commit()
            return category
        except SQLAlchemyError as e:
            db.session.rollback()
            raise e

    @staticmethod
    def get_all_categories(include_relationships=False):
        """Lấy tất cả category, có thể load events"""
        query = Category.query
        if include_relationships:
            query = query.options(joinedload(Category.events))
        return query.all()

    @staticmethod
    def get_category_by_id(category_id, include_relationships=False):
        query = Category.query
        if include_relationships:
            query = query.options(joinedload(Category.events))
        return query.get(category_id)

    @staticmethod
    def get_category_by_name(name, include_relationships=False):
        query = Category.query.filter(func.lower(Category.name) == name.lower())
        if include_relationships:
            query = query.options(joinedload(Category.events))
        return query.first()

    @staticmethod
    def update_category(category_id, **kwargs):
        category = CategoryRepository.get_category_by_id(category_id)
        if not category:
            return None
        for key, value in kwargs.items():
            if hasattr(category, key):
                setattr(category, key, value)
        try:
            db.session.commit()
            return category
        except SQLAlchemyError as e:
            db.session.rollback()
            raise e

    @staticmethod
    def delete_category(category_id):
        category = CategoryRepository.get_category_by_id(category_id)
        if not category:
            return False
        try:
            db.session.delete(category)
            db.session.commit()
            return True
        except SQLAlchemyError as e:
            db.session.rollback()
            raise e

    @staticmethod
    def get_category_events(category_id):
        """Trả về danh sách tên sự kiện của category"""
        category = CategoryRepository.get_category_by_id(category_id, include_relationships=True)
        if not category:
            return []
        # Mỗi Event chỉ có 1 category, nên vẫn dùng category.events
        return [event.title for event in category.events]

    @staticmethod
    def search(keyword=None, include_relationships=True):
        """Tìm category theo keyword tên"""
        query = Category.query
        if keyword:
            query = query.filter(Category.name.ilike(f"%{keyword}%"))
        if include_relationships:
            query = query.options(joinedload(Category.events))
        return query.all()
