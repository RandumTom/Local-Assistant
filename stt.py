import sounddevice as sd
import numpy as np
from faster_whisper import WhisperModel  # type: ignore

# This is all for getting the audio into python
#These next comments hopfully help futre me maintain this mess 

SAMPLE_RATE = 16000 # 16khz, needed for the wispher mdoel I'm using.
CHANNELS = 1 # Mono audio, also required by the wispher model.
SILENCE_THRESHOLD = 0.01 # volume below this = silence
SILENCE_DURATION = 3 # seconds of silence before stopping recording

def record_until_silence():
    print("Recording...")    

    recorded_chunks = []
    silence_chunks = 0
    chucks_per_second = 10 
    silent_limit = int(SILENCE_DURATION * chucks_per_second)
    blocksize = SAMPLE_RATE // chucks_per_second  # ← add this line
    
    def callback(indata, frames, time, status):
        nonlocal silence_chunks
        volume = np.linalg.norm(indata)
        recorded_chunks.append(indata.copy())
        
        if volume < SILENCE_THRESHOLD:
            silence_chunks += 1
        else:
            silence_chunks = 0
        
    with sd.InputStream(samplerate=SAMPLE_RATE, channels=CHANNELS, blocksize=blocksize, callback=callback):  # ← removed duplicate callback
        while silence_chunks < silent_limit:
            sd.sleep(100)
    
    # ← these two lines are now outside the with block
    audio = np.concatenate(recorded_chunks, axis=0)
    return audio.flatten()

# This is now getting the audio into text that the assistant can understand

model = WhisperModel("small", device="cpu", compute_type="int8")

def transcribe(audio):
    segments, _ = model.transcribe(audio, vad_filter=True, language="en")
    transcript = " ".join(segment.text for segment in segments)
    return transcript.strip().lower()