from django.shortcuts import render
from openai import OpenAI
from dotenv import load_dotenv
import os
from django.http import HttpResponse

load_dotenv("./env")

from django.conf import settings
from openai import OpenAI

DEEPSEEK_API_KEY = os.getenv("DEEPSEEK_API_KEY")
GITHUB_KEY = os.getenv("GITHUB_KEY")
GITHUB_BASE_KEY = "https://models.inference.ai.azure.com"

def index(request):
    client = OpenAI(
        api_key=GITHUB_KEY,
        base_url=GITHUB_BASE_KEY,
    )
    
    if request.method == "POST":
        try:
            response = client.chat.completions.create(
                model="gpt-4o-mini",
                messages=[{"role": "user", "content": request.POST.get("user_message")}],
                temperature=1,
                max_tokens=1000,
                top_p=1
            )
            ai_response = response.choices[0].message.content
        except Exception as e:
            ai_response = f"Error: {str(e)}"
        return render(request, 'index.html', {'response': ai_response})
    
    return render(request, 'index.html')