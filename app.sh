#!/bin/bash
echo "Starting Map Application on port 8080..."
# Serve index.html using Python's built-in HTTP server
python3 -m http.server 8080 --bind 0.0.0.0
