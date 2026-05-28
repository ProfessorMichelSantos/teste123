FROM python:3.10-slim

ENV PYTHONUNBUFFERED=1

WORKDIR /app

COPY . .

RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 8080

CMD ["sh", "-c", "gunicorn biblioteca.wsgi:application --bind 0.0.0.0:${PORT:-8080}"]
