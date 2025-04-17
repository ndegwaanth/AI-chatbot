#!/bin/bash

# ==============================================
# CREATE AI E-COMMERCE PROJECT STRUCTURE
# ==============================================

# Project root directory
PROJECT_NAME="ai_ecom_assistant"
mkdir -p $PROJECT_NAME
cd $PROJECT_NAME

# Create core directories
mkdir -p \
  ai/image_generator \
  ai/chat_model \
  ai/product_search \
  static/css \
  static/js \
  static/images \
  templates \
  tests \
  data

# Create essential files
touch \
  app.py \
  config.py \
  requirements.txt \
  README.md \
  .env \
  .gitignore \
  ai/__init__.py \
  ai/image_generator/__init__.py \
  ai/image_generator/image_generator.py \
  ai/chat_model/__init__.py \
  ai/chat_model/chat_model.py \
  ai/product_search/__init__.py \
  ai/product_search/product_search.py \
  templates/index.html \
  templates/products.html \
  static/css/styles.css \
  static/js/app.js

# Create a basic requirements.txt
cat > requirements.txt <<EOL
# Backend
flask==2.3.2
flask-cors==3.0.10
python-dotenv==1.0.0

# AI Models
transformers==4.35.2
torch==2.1.0
accelerate==0.24.1
bitsandbytes==0.41.1
diffusers==0.24.0
pillow==10.0.1

# Database
sqlalchemy==2.0.23
psycopg2-binary==2.9.9

# Payments
stripe==5.5.0
EOL

# Create a minimal .gitignore
cat > .gitignore <<EOL
__pycache__/
*.py[cod]
.env
*.sqlite3
/static/products/
.DS_Store
EOL

# Create basic Flask app.py skeleton
cat > app.py <<EOL
from flask import Flask, render_template, request, jsonify
from ai.image_generator import generate_product_image
from ai.chat_model import get_ai_response
from ai.product_search import get_product_info
import stripe
import os
from dotenv import load_dotenv

load_dotenv()

app = Flask(__name__)
stripe.api_key = os.getenv("STRIPE_API_KEY")

@app.route("/")
def home():
    return render_template("index.html")

@app.route("/api/chat", methods=["POST"])
def chat():
    user_input = request.json.get("message")
    # Add your logic here
    return jsonify({"response": "AI response here"})

@app.route("/api/purchase", methods=["POST"])
def purchase():
    # Stripe integration logic here
    return jsonify({"status": "Payment processed"})

if __name__ == "__main__":
    app.run(debug=True)
EOL

# Create basic HTML template
cat > templates/index.html <<EOL
<!DOCTYPE html>
<html>
<head>
    <title>AI E-Commerce Assistant</title>
    <link rel="stylesheet" href="/static/css/styles.css">
</head>
<body>
    <div id="app">
        <h1>AI Shopping Assistant</h1>
        <div id="chat-container"></div>
        <input type="text" id="user-input" placeholder="Ask for products...">
        <button id="send-btn">Send</button>
    </div>
    <script src="/static/js/app.js"></script>
</body>
</html>
EOL

# Set execute permission for the script
chmod +x ../$0

echo "✅ Project '$PROJECT_NAME' created successfully!"
echo "Next steps:"
echo "1. cd $PROJECT_NAME"
echo "2. python -m venv venv && source venv/bin/activate"
echo "3. pip install -r requirements.txt"
echo "4. Set up your .env file with Stripe/API keys"
echo "5. python app.py"
