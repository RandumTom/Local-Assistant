import sys
from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine
from PySide6.QtGui import QFont

app = QGuiApplication(sys.argv)

defaultFont = QFont("Inter", 10)
app.setFont(defaultFont)

engine = QQmlApplicationEngine()

engine.load("GUI/main.qml")

if not engine.rootObjects():
    sys.exit(-1)

sys.exit(app.exec())