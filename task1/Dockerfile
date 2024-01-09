FROM python:3.9-slim

WORKDIR /app

COPY requirements.txt requirements.txt
RUN pip3 install -r requirements.txt

COPY web-server.py web-server.py

EXPOSE 8080
CMD [ "python3", "web-server.py"]