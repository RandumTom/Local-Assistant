# Dependencies

All third-party Python packages used by Local Assistant.

## Python Packages

| Package | Purpose | Notes |
|---------|---------|-------|
| PySide6 | Qt GUI framework and QML engine | Provides the native desktop window and QML rendering |
| faster-whisper | Speech-to-text | CTranslate2-based Whisper implementation. Uses the "small" model with CPU int8 by default. GPU (CUDA) optional for faster inference. |
| kittentts | Text-to-speech | Uses the KittenML/kitten-tts-micro-0.8 model. 8 voice options. Generates audio at 24kHz. |
| sounddevice | Audio input/output | Records microphone input for STT and plays TTS audio output. Wraps PortAudio. |
| numpy | Audio array processing | Used by sounddevice and faster-whisper for audio buffer handling |
| requests | HTTP client | Used by the weather skill to call the wttr.in API |
| evdev | Linux input device access | Reads keyboard events directly from /dev/input/ for global hotkey support. Works on Wayland. |
| art | ASCII art text | Used in CLI mode for decorative text output (tprint) |
| colorama | Terminal colors | Used in CLI mode for colored terminal output |

## System Dependencies

**Audio**: A working audio system is required. PipeWire, PulseAudio, or ALSA all work. The sounddevice package uses PortAudio under the hood, which most Linux distributions ship by default.

**Input group**: For global hotkey support, your user must be in the `input` group to read from `/dev/input/` event devices:

```
sudo usermod -aG input $USER
```

Log out and back in after running this command.

**CUDA (optional)**: For GPU-accelerated speech-to-text, you need NVIDIA drivers and a compatible CUDA toolkit. Without CUDA, faster-whisper falls back to CPU inference, which is slower but works fine.

## Heavy Transitive Dependencies

These are not listed in `requirements.txt` but are pulled in automatically by pip:

- **PyTorch** -- required by kittentts for TTS model inference
- **CTranslate2** -- required by faster-whisper for efficient Whisper inference
- **Qt6 libraries** -- bundled with PySide6
- **NVIDIA CUDA libraries** -- installed by PyTorch if a compatible GPU is detected

These account for the bulk of the install size. A fresh install of all dependencies will be several gigabytes, mostly due to PyTorch and Qt6.
