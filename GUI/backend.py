import json
from PySide6.QtCore import QObject, Slot, Signal, Property
from datetime import datetime

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
            return "Late night,"
        elif hour <= 5:
            return "Go to bed"
        elif hour <= 10:
            return "Good Moring"
        elif hour <= 15:
            return "Good Afternoon"
        else:
            return "Good Evening"
            
    greeting = Property(str, _get_greeting, notify=greetingChanged)
    
    @Slot(str)
    def sendMessage(self, message):
        print(f"User sent: {message}")
        self._response = f"You said: {message}"
        self.responseChanged.emit()
        
    def _get_response(self):
        return self._response
        
    response = Property(str, _get_response, notify=responseChanged)
    
    def _get_username(self):
        return self._config.get("name", "User")
        
    username = Property(str, _get_username, constant=True)