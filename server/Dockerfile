FROM python:3.10-slim

WORKDIR /app
COPY . /app

RUN pip install --no-cache-dir websockets==14.1

EXPOSE 8080

CMD ["python", "server.py", "--host", "0.0.0.0", "--port", "8080"]