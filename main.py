import json
import os
from art import tprint

CONFIG_FILE = "config.json"

def load_name():
    if os.path.exists(CONFIG_FILE):
        with open(CONFIG_FILE, "r") as f:
            data = json.load(f)
            return data.get("name")
    return None

def save_name(name):
    with open(CONFIG_FILE, "w") as f:
        json.dump({"name": name}, f)

name = load_name()

if name is None:
    print("Hello! What do you want me to call you?")
    name = input()
    save_name(name)

tprint(f"Hello, {name}!", font="tarty1")