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
