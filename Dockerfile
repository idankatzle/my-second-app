FROM python:3.9-slim

WORKDIR /app

# 1111111ת
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY app.py .

EXPOSE 8080

CMD ["python", "app.py"]
