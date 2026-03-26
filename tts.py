from kittentts import KittenTTS
import sounddevice as sd

model = KittenTTS("KittenML/kitten-tts-mini-0.8")

def speak(text, voice=None):
    global assistantVoice
    audio = model.generate(text, voice=voice or assistantVoice or "Jasper")
    sd.play(audio, samplerate=24000)
    sd.wait()