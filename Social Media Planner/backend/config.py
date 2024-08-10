from dotenv import load_dotenv
import os
import redis

load_dotenv()

class ApplicationConfig:
    SECRET_KEY = os.environ["SECRET_KEY"]
    
    SQLALCHEMY_TRACK_MODIFICATIONS = False 
    SQLALCHEMY_ECHO = True
    SQLALCHEMY_DATABASE_URI = r"mysql://root:rootroot@database-1.cjqnnhcojjvw.us-east-1.rds.amazonaws.com:3306/initial_db"
    
    SESSION_TYPE = "redis"
    SESSION_PERMANENT = True 
    SESSION_USE_SIGNER = True 
    SESSION_REDIS = redis.from_url("redis://redis:6379")
    
    FACEBOOK_APP_ID = 951803645868211
    FACEBOOK_APP_SECRET = '6136e4713bf16ec0e49a7b42309f078b'