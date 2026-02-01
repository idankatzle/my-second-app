# השתמש בגרסה קלה של פייתון
FROM python:3.9-slim

# הגדרת תיקיית העבודה בתוך הקונטיינר
WORKDIR /app

# התקנת Flask
RUN pip install --no-cache-dir flask

# העתקת קוד האפליקציה מהמחשב שלך לקונטיינר
COPY app.py .

# חשיפת הפורט שהאפליקציה מאזינה לו
EXPOSE 8080

# פקודת ההרצה
CMD ["python", "app.py"]
