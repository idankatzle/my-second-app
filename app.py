from flask import Flask, render_template_string
import os
import socket
from datetime import datetime

app = Flask(__name__)

@app.route('/')
def hello():
    # שליפת נתונים מהסביבה של OpenShift
    pod_name = socket.gethostname()
    current_time = datetime.now().strftime("%H:%M:%S")
    
    html = f"""
    <!DOCTYPE html>
    <html>
    <head>
        <title>Tekton Pipeline Demo</title>
        <style>
            body {{ font-family: sans-serif; background-color: #2c3e50; color: white; text-align: center; padding-top: 50px; }}
            .card {{ background: #34495e; padding: 20px; border-radius: 15px; display: inline-block; box-shadow: 0 4px 8px rgba(0,0,0,0.5); border: 2px solid #3498db; }}
            h1 {{ color: #3498db; }}
            .highlight {{ color: #2ecc71; font-weight: bold; }}
        </style>
    </head>
    <body>
        <div class="card">
            <h1>🚀 Deployment Successful!</h1>
            <p>App Name: <span class="highlight">My Second App</span></p>
            <p>Running on Pod: <span class="highlight">{pod_name}</span></p>
            <p>Last Updated: <span class="highlight">{current_time}</span></p>
            <hr>
            <p><i>Managed by Tekton Pipeline @ 2026</i></p>
        </div>
    </body>
    </html>
    """
    return render_template_string(html)

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=8080)
