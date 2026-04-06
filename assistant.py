import re

from intents import INTENTS
from stt import record_until_silence, transcribe
from tts import speak
from Skills.time_date import get_date, get_time, get_time_and_date
from Skills.weather import get_weather
from Skills.update_system import update_system

SKILL_MAP = {
    "get_time":          get_time,
    "get_date":          get_date,
    "get_time_and_date": get_time_and_date,
    "get_weather":       get_weather,
    "update_system":     update_system,
}


def match_input(transcribe):
    for pattern, skill_name in INTENTS:
        match = re.search(pattern, transcribe)
        if match:
            return skill_name, match
    return None, None

def run_once():
    audio = record_until_silence()
    transcript = transcribe(audio)
    print(f"Input: {transcript}")
    
    skill_name, match = match_input(transcript)
    
    if skill_name and skill_name in SKILL_MAP:
        response = SKILL_MAP[skill_name]()
        print(response)
        speak(response)
    else:
        speak("What? I couldn't understand shit of that. My bad!")
        
def run_assistant():
    try:
        while True:
            run_once()
    except KeyboardInterrupt:
        print("Goodbye! See you soon.")