import json
import os
from art import tprint

# Define the path to the config file
CONFIG_FILE = "config.json"

# Create a new config file if it doesn't exist
if not os.path.exists(CONFIG_FILE):
    with open(CONFIG_FILE, "w") as f:
        json.dump({}, f)

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

# Prompt the user for their name if it hasn't been set yet
if name is None:
    print("Hello! What do you want me to call you?")
    name = input()
    save_name(name)

#Print a greeting message using art and the name given
tprint(f"Hello, {name}!", font="tarty1")

