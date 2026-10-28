FROM python:3.14-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 8002
CMD ["gunicorn", "--bind", "0.0.0.0:8002", "app:app"]

HEALTHCHECK --interval=30s --timeout=3s --start-period=10s --retries=3 \
CMD ["python", "-c", "import urllib.request; urllib.request.urlopen('http://127.0.0.1:8002/ready', timeout=2)"]