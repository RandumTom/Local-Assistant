import json
import os
from datetime import datetime
import uuid

CHATS_FILE = "chats.json"

if not os.path.exists(CHATS_FILE):
    with open(CHATS_FILE, "w") as f:
        json.dump([], f)
        
def loadChats():
    with open(CHATS_FILE, "r") as f:
        return json.load(f)
        
def saveChats(user_message, assistant_response):
    chats = loadChats()
    chats.append({
        "id": str(uuid.uuid4()),
        "timestamp": datetime.now().isoformat(),
        "messages": [
            {"role": "user", "text": user_message},
            {"role": "assistant", "text": assistant_response}
        ]
    })
    with open(CHATS_FILE, "w") as f:
        json.dump(chats, f, indent=2)
        
def clearChats():
    with open(CHATS_FILE, "w") as f:
        json.dump([], f)