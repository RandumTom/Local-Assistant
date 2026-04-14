# Local Assistant

A native Linux voice assistant with a dark-themed desktop GUI, local speech-to-text, local text-to-speech, and extensible skills.

## What This Is

Local Assistant is a native desktop application built with PySide6 and QML (not Electron, not a web wrapper). Everything runs locally on your machine. Voice input is handled by faster-whisper (a local Whisper implementation), and voice output by kittentts. There is no cloud AI involved.

The assistant uses regex-based intent matching to dispatch user input (typed or spoken) to skill modules that handle things like telling the time, checking the weather, or updating your system.

## Features

- Native dark-themed GUI built with PySide6 and QML, using JetBrains Mono
- Local speech-to-text via faster-whisper (runs on CPU by default, CUDA GPU optional)
- Local text-to-speech via kittentts with 8 voice options (Bella, Jasper, Luna, Bruno, Rosie, Hugo, Kiki, Leo)
- Built-in skills: time/date, weather (via wttr.in), system update (More to come, like Websearch, A local AI Model and more!)
- Global hotkey support that works on Wayland (via evdev)
- Chat history stored locally as JSON, with a toggle to enable/disable saving
- Settings page: voice picker, city, display name, hotkey capture, update command, save-chats toggle
- First-time setup wizard
- CLI mode available as an alternative to the GUI (But not recommended, since the GUI has better feature support and is going to be the main focus of development)

## Requirements

- Linux (tested on Fedora 43, should work on other distros)
- Python 3.12+
- A working audio system (PipeWire, PulseAudio, or ALSA)
- Optional: NVIDIA GPU with CUDA for faster whisper inference

## Installation

1. Clone the repository:

```
git clone https://github.com/RandumTom/Local-Assistant.git
cd Local-Assistant
```

2. Create and activate a virtual environment:

```
python3 -m venv localAssistant
source localAssistant/bin/activate
```

3. Install dependencies:

```
pip install -r requirements.txt
```

4. For global hotkey support, add your user to the `input` group:

```
sudo usermod -aG input $USER
```

Then log out and back in for the group change to take effect.

See [DEPENDENCIES.md](DEPENDENCIES.md) for details on each package.

## Usage

**GUI mode** (recommended):

```
python GUI/gui.py
```

**CLI mode**:

```
python main.py
```

On first launch, the setup wizard will prompt for your name, preferred voice, and city. These can be changed later in the settings page.

The global hotkey (configurable in settings) triggers voice input from anywhere on the desktop, even when the app is in the background.

## Project Structure

```
Local Assistant/
├── main.py                 CLI entry point
├── assistant.py            Intent matching and skill dispatch
├── stt.py                  Speech-to-text (faster-whisper)
├── tts.py                  Text-to-speech (kittentts)
├── intents.py              Regex intent patterns
├── chatStorage.py          Chat history persistence (JSON)
├── hotkeyListener.py       Global hotkey listener (evdev)
├── requirements.txt        Python dependencies
│
├── GUI/
│   ├── gui.py              PySide6 QML engine entry point
│   ├── backend.py          Python backend exposed to QML
│   ├── main.qml            QML UI (home, settings, chats, setup)
│   ├── fonts/              JetBrains Mono font files
│   └── images/             SVG icons (mic, settings gear, chats)
│
└── Skills/
    ├── time_date.py        Time and date skill
    ├── weather.py          Weather skill (wttr.in)
    └── update_system.py    System update skill
```

## Configuration

Both configuration files are generated automatically on first run:

- `config.json` -- stores name, voice, city, update command, hotkey, and save-chats preference
- `secrets.json` -- stores the sudo password (optional, used by the system update skill)

Neither file is tracked by git.

## Adding Skills

1. Create a new Python file in `Skills/` with a function that returns a response string
2. Add a regex pattern to `intents.py` mapping to a skill name
3. Import the function and register it in `SKILL_MAP` in `assistant.py`
