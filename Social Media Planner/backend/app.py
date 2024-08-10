from flask import Flask, request, jsonify, session
from flask_bcrypt import Bcrypt
from flask_cors import CORS
from flask_session import Session
from config import ApplicationConfig
from models import db, User
from flask_mail import Mail, Message
import re
import redis, random, string
import requests
import sys


app = Flask(__name__)
app.config.from_object(ApplicationConfig)

#config mail server
app.config['MAIL_SERVER'] = 'smtp.mail.yahoo.com'
app.config['MAIL_PORT'] = 465
app.config['MAIL_USE_SSL'] = True
app.config['MAIL_USERNAME'] = 'andronic.dragos@yahoo.com'
app.config['MAIL_PASSWORD'] = 'nkcxgmslfemfmmsk'
app.config['MAIL_USE_TLS'] = False
#app.config['MAIL_USE_SSL'] = True

# the redis client for local storage of key-value pairs
redis_client = redis.Redis(host="redis", port=6379, db=0, decode_responses=True)
bcrypt = Bcrypt(app) # used for hashing passwords
CORS(app, supports_credentials=True)
server_session = Session(app) # enables server-sided user sessions
db.init_app(app) # initializes the database
mail = Mail(app) # initializes mail object

# creates the tables in the database
with app.app_context():
    db.create_all()
    
def validate_email(email):
    # Regular expression pattern for email validation
    pattern = r'^[\w\.-]+@[\w\.-]+\.\w+$'
    if re.match(pattern, email):
        return True
    else:
        return False
    
@app.route("/signup", methods = ["POST"])
def signup_user():
    # we get the new user info
    email = request.json["email"]
    password = request.json["password"]
    confirmed_password = request.json["confirmed_password"]
    
    # check conditions for password
    if len(password) < 12:
        return jsonify({
            "error": "Password not long enough" 
        }), 400
        
    # we check if the email has the right format
    if not validate_email(email):
        return jsonify({
            "error": "Email has incorrect format" 
        }), 400
    
    # we check if the passwords match
    if password != confirmed_password:
        return jsonify({
            "error": "Passwords do not match" 
        }), 400
    
    # we check if the a user with that email already exists
    user_exists = User.query.filter_by(email = email).first() is not None 
    if user_exists: # we cannot have two users with the same email
        return jsonify({
                "error": "User already exists"
        }), 409
    
    # we hash the password and create a new user entry
    hashed_password = bcrypt.generate_password_hash(password)
    new_user = User(email = email, password = hashed_password)
    
    # we save the database changes
    db.session.add(new_user)
    db.session.commit()
    
    # create a session for the user
    session["user_id"] = new_user.id_user
    
    return jsonify({
        "id": new_user.id_user,
        "email": new_user.email
    })
    

@app.route("/login", methods = ["POST"])
def login_user():
    # we get the user login info
    email = request.json["email"]
    password = request.json["password"]
    
    # we check if the user exists
    user = User.query.filter_by(email = email).first()
    if user is None: 
        return jsonify({
                "error": "User not found"
        }), 404
    
    # we check if the hashes do not match
    if not bcrypt.check_password_hash(user.password, password):
        return jsonify({
                "error": "Incorrect password"
        }), 401
        
    # create session for user
    session["user_id"] = user.id_user
        
    return jsonify({
        "id": user.id_user,
        "email": user.email
    })

@app.route("/logout", methods = ["POST"])
def logout_user():
    # we remove the "user_id" field, thus making the session unavailable
    session.pop("user_id")
    return jsonify({
        'message': 'Logout successful'
    }), 200

@app.route("/recovery", methods = ["POST"])
def recover_account_user():
    # we get the user email 
    email = request.json["email"]
    
    # we look for the account
    user = User.query.filter_by(email = email).first()

    if user is None: 
        return jsonify({
                "error": "No user with that email was found"
        }), 404

    # we add a random string to the url, to uniquely identify the user that wants their password changed
    url_extension = ''.join(random.choices(string.ascii_letters + string.digits, k = 50))
    
    # we add a key-value pair in the redis database, such that we may find the email
    # when the user uses the random string to change their password
    redis_client.psetex(url_extension, 86400000, email)
    
    # we prepare and send the email
    msg = Message('SocialMediaPlanner Password Change', sender = 'andronic.dragos@yahoo.com', recipients = [user.email])
    msg.body = "This is a link to change your password: " + "http://localhost:3000/password_change/" + url_extension
    mail.send(msg)
    
    return jsonify({"message":
        "Email sent!"
    }), 200

@app.route("/password_change/<url_extension>", methods = ["POST"])
def password_change(url_extension):
    # we check if the id to change password exists in the redis database,
    # thus signaling a valid password change request
    if redis_client.exists(url_extension) == 0:
        return jsonify({
                "error": "No request to reset password with that link"
        }), 404
    
    # we get the email of the user that wants their password changed
    email = redis_client.get(url_extension)
    
    # we get the new password from the user
    new_password = request.json["new_password"]
    new_confirmed_password = request.json["new_confirmed_password"]
    
    # we get the database entry for the user
    user = User.query.filter_by(email = email).first()

    # this would be useful in the future if a feature to delete account
    # is be implemented
    if user is None: 
        return jsonify({
                "error": "The user with this email no longer exists"
        }), 404
        
    # check password requirements
    if len(new_password) < 12:
        return jsonify({
            "error": "Password not long enough" 
        }), 400
    
    if new_password != new_confirmed_password:
        return jsonify({
            "error": "Passwords do not match" 
        }), 400
    
    # update the user's password and commit it to the database
    user.password = bcrypt.generate_password_hash(new_password)
    db.session.commit()
    
    # we remove the id, otherwise the account would be lost if a recovery
    # link got leaked
    redis_client.delete(url_extension)
    
    return jsonify({
        'message': "Password changed succesfully!"
    }), 200

@app.route("/main")
def main_page():
    user_id = session.get("user_id")
    
    if not user_id:
        return jsonify({
                "error": "Unauthorized"
        }), 401
        
    user = User.query.filter_by(id_user = user_id).first()
    
    return jsonify({
        "id": user.id_user,
        "email": user.email
    })
    
@app.route("/facebook_login", methods = ["POST"])
def facebook_login():
  accessToken = request.json["accessToken"]
  
  # extend token
  url = 'https://graph.facebook.com/v16.0/oauth/access_token'
  params = {
    'grant_type': 'fb_exchange_token',
    'client_id': app.config['FACEBOOK_APP_ID'],
    'client_secret': app.config['FACEBOOK_APP_SECRET'],
    'fb_exchange_token': accessToken
  }
  accessToken = requests.get(url, params = params).json().get('access_token')
  
  # store token
  user_id = session.get("user_id")
  user = User.query.filter_by(id_user = user_id).first()
  user.facebook_token = accessToken
  db.session.commit()
  
  return "200"

if __name__ == '__main__':
    app.run(host = '0.0.0.0', debug = True)