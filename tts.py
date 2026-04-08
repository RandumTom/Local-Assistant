from kittentts import KittenTTS
import sounddevice as sd

model = KittenTTS("KittenML/kitten-tts-micro-0.8")

def speak(text, voice=None):
    audio = model.generate(text, voice=voice or "Jasper")
    sd.play(audio, samplerate=24000)
    sd.wait()