from flask_sqlalchemy import SQLAlchemy
from uuid import uuid4

db = SQLAlchemy()

def get_uuid():
    return uuid4().hex

class User(db.Model):
    """
        Stores data about users
    """
    __tablename__ = "USER"
    id_user = db.Column(db.String(32), primary_key = True, unique = True, default = get_uuid)
    email = db.Column(db.String(500), unique = True, nullable = False)
    password = db.Column(db.Text, nullable = False)
    facebook_token = db.Column(db.String(500))
    instagram_token = db.Column(db.String(500))
    twitter_token = db.Column(db.String(500))
    
class PostMetadata(db.Model):
    """ 
      Stores data about posts
    """
    __tablename__ = "POST_METADATA"
    id_post_metadata = db.Column(db.String(32), primary_key = True, unique = True, default = get_uuid)
    id_user = db.Column(db.String(32), db.ForeignKey("USER.id_user"), primary_key = True, unique = True, default = get_uuid)
    id_post = db.Column(db.String(32), db.ForeignKey("POST.id_post"), primary_key = True, unique = True, default = get_uuid)
    upload_time = db.Column(db.DateTime, nullable = False)
    on_facebook = db.Column(db.Boolean, default = False)
    on_twitter = db.Column(db.Boolean, default = False)
    on_instagram = db.Column(db.Boolean, default = False)
    
class Post(db.Model):
    """ 
      Stores actual post
    """ 
    __tablename__ = "POST" 
    id_post = db.Column(db.String(32), primary_key = True, unique = True, default = get_uuid)
    text = db.Column(db.Text)
    image = db.Column(db.LargeBinary)
    video = db.Column(db.LargeBinary)