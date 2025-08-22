FROM python:3.10-slim

WORKDIR /app
COPY . /app

RUN pip install websockets

EXPOSE 8000

ENV HOST=0.0.0.0
ENV PORT=8000

CMD ["python", "server.py"]