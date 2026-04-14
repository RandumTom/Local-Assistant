import evdev
import select
import threading
from evdev import ecodes, KeyEvent

KEY_NAME_MAP = {
    "Ctrl": {ecodes.KEY_LEFTCTRL, ecodes.KEY_RIGHTCTRL},
    "Alt": {ecodes.KEY_LEFTALT, ecodes.KEY_RIGHTALT},
    "Shift": {ecodes.KEY_LEFTSHIFT, ecodes.KEY_RIGHTSHIFT},
    "Super": {ecodes.KEY_LEFTMETA, ecodes.KEY_RIGHTMETA},
    "Space": {ecodes.KEY_SPACE},
    "Enter": {ecodes.KEY_ENTER},
    "Tab": {ecodes.KEY_TAB},
    "Backspace": {ecodes.KEY_BACKSPACE},
    "Delete": {ecodes.KEY_DELETE},
    "Copilot Key": {ecodes.KEY_F23},
    "Up": {ecodes.KEY_UP},
    "Down": {ecodes.KEY_DOWN},
    "Left": {ecodes.KEY_LEFT},
    "Right": {ecodes.KEY_RIGHT},
    "Escape": {ecodes.KEY_ESC},
}

for c in range(ord('A'), ord('Z') + 1):
    KEY_NAME_MAP[chr(c)] = {getattr(ecodes, f"KEY_{chr(c)}")}
    
for n in range(10):
    KEY_NAME_MAP[str(n)] = {getattr(ecodes, f"KEY_{n}")}

for f in range(1, 36):
    key_attr = f"KEY_F{f}"
    if hasattr(ecodes, key_attr):
        KEY_NAME_MAP[f"F{f}"] = {getattr(ecodes, key_attr)}
        
def parse_hotkey(hotkey_string):
    """Convert 'Ctrl+Alt+T' into a set of evdev key codes sets."""
    if not hotkey_string:
        return None
    parts = hotkey_string.split("+")
    required_keys = []
    for part in parts:
        part = part.strip()
        if part in KEY_NAME_MAP:
            required_keys.append(KEY_NAME_MAP[part])
        else:
            return None
    return required_keys

def find_keyboards():
    """Find all keyboard input devices."""
    keyboards = []
    for path in evdev.list_devices():
        device = evdev.InputDevice(path)
        caps = device.capabilities(verbose=False)
        if ecodes.EV_KEY in caps:
            key_codes = caps[ecodes.EV_KEY]
            if ecodes.KEY_A in key_codes and ecodes.KEY_Z in key_codes:
                keyboards.append(device)
    return keyboards
        
class HotkeyListener:
    def __init__(self, callback):
        self._callback = callback
        self._hotkey = None
        self._running = False
        self._thread = None
        self._pressed_keys = set()
        
    def set_hotkey(self, hotkey_string):
        self._hotkey = parse_hotkey(hotkey_string)
        
    def start(self):
        self._running = True
        self._thread = threading.Thread(target=self._listen, daemon=True)
        self._thread.start()
        
    def stop(self):
        self._running = False
        
    def _check_hotkey(self):
        if not self._hotkey:
            return False
        for key_set in self._hotkey:
            if not any(k in self._pressed_keys for k in key_set):
                return False
        return True
        
    def _listen(self):
        keyboards = find_keyboards()
        if not keyboards:
            print("No keyboards found. Is user in 'input' group?")
            return
            
        print(f"Listening on: {[kb.name for kb in keyboards]}")
        
        while self._running:
            fds = {kb.fd: kb for kb in keyboards}
            r, _, _ = select.select(fds.keys(), [], [], 1)
            for fd in r:
                device = fds[fd]
                try:
                    for event in device.read():
                        if event.type != ecodes.EV_KEY:
                            continue
                        if event.value == KeyEvent.key_down:
                            self._pressed_keys.add(event.code)
                            if self._check_hotkey():
                                self._callback()
                        elif event.value == KeyEvent.key_up:
                            self._pressed_keys.discard(event.code)
                except OSError:
                    pass