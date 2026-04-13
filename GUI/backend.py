#GUI Imports
import json
import sys
import os
import threading
from PySide6.QtCore import QObject, Slot, Signal, Property
from datetime import datetime

#Logic Imports
sys.path.insert(0, os.path.join(os.path.dirname(__file__), ".."))
from assistant import match_input, SKILL_MAP
from stt import record_until_silence, transcribe
from tts import speak

class Backend(QObject):
    greetingChanged = Signal()
    responseChanged = Signal()
    
    def __init__(self):
        super().__init__()
        self._response = ""
        with open("config.json", "r") as f:
            self._config = json.load(f)
        
    def _get_greeting(self):
        hour = datetime.now().hour
        if hour < 1:
            return "Late night"
        elif hour <= 5:
            return "Go to bed"
        elif hour <= 10:
            return "Good Moring"
        elif hour <= 15:
            return "Good Afternoon"
        else:
            return "Good Evening"
            
    greeting = Property(str, _get_greeting, notify=greetingChanged)
        
    def _get_response(self):
        return self._response
        
    response = Property(str, _get_response, notify=responseChanged)
    
    def _get_username(self):
        return self._config.get("name", "User")
        
    username = Property(str, _get_username, constant=True)
    
    @Slot(str)
    def sendMessage(self, message):
        """Handle typed text input - intent matching on it directly."""
        skill_name, match = match_input(message.lower())
        if skill_name and skill_name in SKILL_MAP:
            result = SKILL_MAP[skill_name]()
            self._response = result
            speak(result)
        else:
            self._response = "I didn't understand that."
            speak(self._response)
        self.responseChanged.emit()
        
    @Slot()
    def micPressed(self):
        """Handle mic button - record, transcribe, then process"""
        threading.Thread(target=self._do_voice_input, daemon=True).start()
        
    def _do_voice_input(self):
        audio = record_until_silence()
        transcript = transcribe(audio)
        print(f"Heard: {transcript}")
        
        skill_name, match = match_input(transcript)
        if skill_name and skill_name in SKILL_MAP:
            result = SKILL_MAP[skill_name]()
            self._response = result
            speak(result)
        else:
            self._response = "I don't understand that."
            speak(self._response)
        self.responseChanged.emit()
        
    @Slot()
    def settingsPressed(self):
        """Handle settings button"""
        print("Settings opened")
        
    @Slot()
    def chatsPressed(self):
        """Handle chats button."""
        print("Chats opened")
        
    @Slot(result=str)
    def getAssistantVoice(self):
        """Return the assistant voice from config."""
        return self._config.get("assistantVoice", "Jasper")
        
    @Slot(str)
    def saveAssistantVoice(self, voice):
        self._config["assistantVoice"] = voice
        with open("config.json", "w") as f:
            json.dump(self._config, f)
            
    @Slot(result=str)
    def getCity(self):
        return self._config.get("city", "")
        
    @Slot(str)
    def saveCity(self, city):
        self._config["city"] = city
        with open("config.json", "w") as f:
            json.dump(self._config, f)
            
    @Slot(result=str)
    def getName(self):
        return self._config.get("name", "")
        
    @Slot(str)
    def saveName(self, name):
        self._config["name"] = name
        with open("config.json", "w") as f:
            json.dump(self._config, f)

    @Slot(result=str)
    def getUpdateCommand(self):
        return self._config.get("package_manager", "")
        
    @Slot(str)
    def saveUpdateCommand(self, command):
        self._config["package_manager"] = command
        with open("config.json", "w") as f:
            json.dump(self._config, f)
            
    @Slot(str)
    def saveSudoPassword(self, password):
        import json as _json
        with open("secrets.json", "w") as f:
            secrets = _json.load(f)
            secrets["sudo_password"] = password
            with open("secrets.json", "w") as f:
                _json.dump(secrets, f)
                
    @Slot()
    def resetConfig(self):
        self._config = {}
        with open("config.json", "w") as f:
            json.dump({}, f)
            
    @Slot()
    def resetSecrets(self): 
        with open("secrets.json", "w") as f:
            json.dump({}, f)
            
    @Slot()
    def needsSetup(self):
        return not self._config.get("name")