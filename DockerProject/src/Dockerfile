FROM python:3.8-slim

WORKDIR /api
COPY . /api
RUN apt-get update 
RUN apt-get install -y python3-dev default-libmysqlclient-dev build-essential pkg-config
RUN pip install --upgrade pip 
RUN pip install -r requirements.txt 
RUN pip install python-decouple

EXPOSE 6000
RUN chmod +x wait_for_db.sh
CMD ["./wait_for_db.sh"]