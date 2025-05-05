from openai import OpenAI

DEEPSEEK_API_KEY="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"
base_url="https://api.deepseek.com/v1"

client = OpenAI(api_key=DEEPSEEK_API_KEY, base_url=base_url)


chat = client.chat.completions.create(
        model = "deepseek/deepseek-chat",
        messages=[
            {
                "role": "user",
                "content": "what is the meaning of dsa"
            }
        ]
)


print(chat)
