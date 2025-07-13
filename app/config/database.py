from flask_sqlalchemy import SQLAlchemy
from sqlalchemy import text

db = SQLAlchemy()


def mysql_config(app):
    app.config["SQLALCHEMY_DATABASE_URI"] = (
        "mysql+pymysql://root:@localhost/we2go_database"
    )
    app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False

    db.init_app(app)

    try:
        with app.app_context():
            db.session.execute(text('SELECT 1'))
            print("✅ Connected to MySQL successfully!")
    except Exception as e:
        print("❌ Connection failed:", e)
