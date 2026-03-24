import json
import os
from art import tprint
from kittentts import KittenTTS
import sounddevice as sd

model = KittenTTS("KittenML/kitten-tts-mini-0.8")

def speak(text, voice=None):
    audio = model.generate(text, voice=voice or assistantVoice)
    sd.play(audio, samplerate=24000)
    sd.wait()  # blocks until playback finishes

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
    data = json.load(open(CONFIG_FILE)) if os.path.exists(CONFIG_FILE) else {}
    data["name"] = name
    with open(CONFIG_FILE, "w") as f:
        json.dump(data, f)

name = load_name()

# Prompt the user for their name if it hasn't been set yet
if not name:
    print("Hello! What do you want me to call you?")
    name = input()
    save_name(name)
    tprint(f"Name set to {name}", font="tarty1")

def load_assistant_voice():
    if os.path.exists(CONFIG_FILE):
        with open(CONFIG_FILE, "r") as f:
            data = json.load(f)
            return data.get("assistantVoice")
    return None

def save_assistant_voice(voice):
    data = json.load(open(CONFIG_FILE)) if os.path.exists(CONFIG_FILE) else {}
    data["assistantVoice"] = voice
    with open(CONFIG_FILE, "w") as f:
        json.dump(data, f)

assistantVoice = load_assistant_voice()

# Prompt the user for their assistant voice if it hasn't been set yet
if not assistantVoice:
    print("What voice do you want me to use? You can change this later in the settings.")
    print(" 1. Bella \n 2. Jasper \n 3. Luna \n 4. Bruno \n 5. Rosie \n 6. Hugo \n 7. Kiki \n 8. Leo")
    choice = input()
    if choice == "1":
        assistantVoice = "Bella"
    elif choice == "2":
        assistantVoice = "Jasper"
    elif choice == "3":
        assistantVoice = "Luna"
    elif choice == "4":
        assistantVoice = "Bruno"
    elif choice == "5":
        assistantVoice = "Rosie"
    elif choice == "6":
        assistantVoice = "Hugo"
    elif choice == "7":
        assistantVoice = "Kiki"
    elif choice == "8":
        assistantVoice = "Leo"
    save_assistant_voice(assistantVoice)
    tprint(f"Voice set to {assistantVoice}", font="tarty1")    

#Print a greeting message using art and the name given
tprint(f"Hello, {name}!", font="tarty1")

print("How can I assist you today?")
print("1. Settings")
print("2. Reset Config")

choice = input()
if choice == "1":
    tprint("Settings", font="tarty1")
