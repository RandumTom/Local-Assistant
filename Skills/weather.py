import requests
import json
import os

CONFIG_FILE = "config.json"

def load_city():
    if os.path.exists(CONFIG_FILE):
        with open(CONFIG_FILE, "r") as f:
            data = json.load(f)
            return data.get("city")
    return None

def get_weather(city=None):
    city = city or load_city()

    if not city:
        return "I don't know what city you're in. You can set it in settings."

    try:
        response = requests.get(f"https://wttr.in/{city}?format=3", timeout=5)
        response.raise_for_status()
        return response.text.strip()
    except requests.exceptions.ConnectionError:
        return "I can't reach the weather service right now. Check your internet connection."
    except requests.exceptions.Timeout:
        return "The weather service took too long to respond."
    except Exception:
        return "Something went wrong fetching the weather."

if __name__ == "__main__":
    print(get_weather())
