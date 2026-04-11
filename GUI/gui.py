import sys
from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine
from PySide6.QtGui import QFont
from backend import Backend

app = QGuiApplication(sys.argv)

defaultFont = QFont("Inter", 10)
app.setFont(defaultFont)

engine = QQmlApplicationEngine()

backend = Backend()
engine.setInitialProperties({"backend": backend})

engine.load("GUI/main.qml")

if not engine.rootObjects():
    sys.exit(-1)
    
engine.rootObjects()[0].setProperty("backend", backend)

sys.exit(app.exec())