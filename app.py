import os
from flask import Flask

app = Flask(__name__)

@app.route('/')
def hello_konflux():
    return "Hello from Konflux! I am now a real server."

if __name__ == "__main__":
    # Knative מעביר את הפורט כמשתנה סביבה, אם לא קיים - נשתמש ב-8080
    port = int(os.environ.get('PORT', 8080))
    # חשוב מאוד: host='0.0.0.0' כדי לאפשר גישה מחוץ לקונטיינר
    app.run(debug=True, host='0.0.0.0', port=port)
