import json
import os
from art import tprint
from colorama import Fore, Style#, init # type: ignore
from tts import speak

# Define the path for secrets.json, a config file for non settings, but for stuff like, passwords, api keys etc
SECRETS_FILE = "secrets.json"

if not os.path.exists(SECRETS_FILE):
    with open(SECRETS_FILE, "w") as f:
        json.dump({}, f)

def save_sudo_password(password):
    data = json.load(open(SECRETS_FILE)) if os.path.exists(SECRETS_FILE) else {}
    data["sudo_password"] = password
    with open(SECRETS_FILE, "w") as f:
        json.dump(data, f)

def reset_secrets():
    with open(SECRETS_FILE, "w") as f:
        json.dump({}, f)


# Define the path to the config file
CONFIG_FILE = "config.json"

def reset_config():
    global name, assistantVoice
    
    #Wipe the config file
    with open(CONFIG_FILE, "w") as f:
        json.dump({}, f)

# Create a new config file if it doesn't exist
if not os.path.exists(CONFIG_FILE):
    with open(CONFIG_FILE, "w") as f:
        json.dump({}, f)

def load_name():
    if os.path.exists(CONFIG_FILE):
        with open(CONFIG_FILE, "r") as f:
            data = json.load(f)
            return data.get("name")
    return None

def save_name(name):
    data = json.load(open(CONFIG_FILE)) if os.path.exists(CONFIG_FILE) else {}
    data["name"] = name
    with open(CONFIG_FILE, "w") as f:
        json.dump(data, f)

def save_city(city):
    data = json.load(open(CONFIG_FILE)) if os.path.exists(CONFIG_FILE) else {}
    data["city"] = city
    with open(CONFIG_FILE, "w") as f:
        json.dump(data, f)
        
def define_package_manager(package_manager):
    data = json.load(open(CONFIG_FILE)) if os.path.exists(CONFIG_FILE) else {}
    data["package_manager"] = package_manager
    with open(CONFIG_FILE, "w") as f:
        json.dump(data, f)

name = load_name()

# Prompt the user for their name if it hasn't been set yet
if not name:
    print("Hello! What do you want me to call you?")
    name = input()
    save_name(name)
    tprint(f"Name set to {name}", font="tarty1")

def load_assistant_voice():
    if os.path.exists(CONFIG_FILE):
        with open(CONFIG_FILE, "r") as f:
            data = json.load(f)
            return data.get("assistantVoice")
    return None

def save_assistant_voice(voice):
    data = json.load(open(CONFIG_FILE)) if os.path.exists(CONFIG_FILE) else {}
    data["assistantVoice"] = voice
    with open(CONFIG_FILE, "w") as f:
        json.dump(data, f)

assistantVoice = load_assistant_voice()

# Prompt the user for their assistant voice if it hasn't been set yet
if not assistantVoice:
    print("What voice do you want me to use? You can change this later in the settings.")
    print(" 1. Bella \n 2. Jasper \n 3. Luna \n 4. Bruno \n 5. Rosie \n 6. Hugo \n 7. Kiki \n 8. Leo")
    choice = input()
    if choice == "1":
        assistantVoice = "Bella"
    elif choice == "2":
        assistantVoice = "Jasper"
    elif choice == "3":
        assistantVoice = "Luna"
    elif choice == "4":
        assistantVoice = "Bruno"
    elif choice == "5":
        assistantVoice = "Rosie"
    elif choice == "6":
        assistantVoice = "Hugo" 
    elif choice == "7":
        assistantVoice = "Kiki"
    elif choice == "8":
        assistantVoice = "Leo"
    save_assistant_voice(assistantVoice)
    tprint(f"Voice set to {assistantVoice}", font="tarty1")    
    speak(f"I'm will now be using {assistantVoice} as my voice.", voice=assistantVoice)

#Ask the user in what city they are
print("What city are you in? This is used for weather.")
city = input()
save_city(city)

#Ask the user for the package manager they are using
print("Please type your update command:")
package_manager = input()
define_package_manager(package_manager)

#Print a greeting message using art and the name given
tprint(f"Hello, {name}!", font="tarty1")

while True:
    print("How can I assist you today?")
    print("1. Settings")
    print("2. Reset Config")
    print("Talk to me")

    choice = input()
    if choice == "1":
        tprint("Settings", font="tarty1")
        while True:
            print("1. Change Voice")
            print("2. Change my Name")
            print("3. Use an LLM") #Not yet implemented
            print("4. Change the weather location")
            print("5. Change update command")
            print("6. Add a sudo password")
            print("7. Back")
            choice = input()
            if choice == "1":
                print(" 1. Bella \n 2. Jasper \n 3. Luna \n 4. Bruno \n 5. Rosie \n 6. Hugo \n 7. Kiki \n 8. Leo\n 9. Back")
                choice = input()
                voices = {"1": "Bella", "2": "Jasper", "3": "Luna", "4": "Bruno", "5": "Rosie", "6": "Hugo", "7": "Kiki", "8": "Leo"}
                if choice in voices:
                    assistantVoice = voices[choice]
                    save_assistant_voice(assistantVoice)
                    tprint(f"Voice set to {assistantVoice}", font="tarty1")
                    speak(f"I'm will now be using {assistantVoice} as my voice.", voice=assistantVoice)
                # 9 or anything else goes back to settings menu
            elif choice == "2":
                print("What should I call you from now on?")
                name = input()
                save_name(name)
                
                helloNewName = f"Hello {name}!"
                tprint(helloNewName, font="tarty1")
                speak(helloNewName, voice=assistantVoice)
            
            elif choice == "4":
                print("What City are you in?")
                city = input()
                save_city(city)
            
            elif choice == "5"
                print("Please type your new update command, please include the -y flag: ")
                package_manager = input()
                define_package_manager(package_manager)
            
            elif choice == "6":
                # Sudo password is optional, so we just ask once
                print("Would you like to add a sudo password for system commands? (y/N)")
                print("This is optional and stored locally in secrets.json")
                choice = input()
                if choice == "y":
                    password = input("Enter your sudo password: ")
                    save_sudo_password(password)
                    tprint("Sudo password saved.", font="tarty1")
            
            elif choice == "7":
                break  # back to main menu
    elif choice == "2":
        print(Fore.RED, end='')
        tprint("Are you sure you \n want to reset \n the config?", font="tarty1")
        print(Style.RESET_ALL, end='')
        print("N/y")
        choice = input()
        if choice == "y":
            reset_config() 
            tprint("Config reset.", font="tarty1")
            print("Do you also want to reset secrets.json? (y/N)")
            choice = input()
            if choice == "y":
                reset_secrets()
                tprint("Secrets reset.", font="tarty1")
            #Getting the users name again
            print("Hello! What should I call you?")
            name = input()
            save_name(name)
            tprint(f"Hello {name}!")
            
            #Asking the user for the new Voice the Assistant should use
            print("What voice do you want me to use? You can change this later in the settings.")
            print(" 1. Bella \n 2. Jasper \n 3. Luna \n 4. Bruno \n 5. Rosie \n 6. Hugo \n 7. Kiki \n 8. Leo")
            choice = input()
            if choice == "1":
                assistantVoice = "Bella"
            elif choice == "2":
                assistantVoice = "Jasper"
            elif choice == "3":
                assistantVoice = "Luna"
            elif choice == "4":
                assistantVoice = "Bruno"
            elif choice == "5":
                assistantVoice = "Rosie"
            elif choice == "6":
                assistantVoice = "Hugo"
            elif choice == "7":
                assistantVoice = "Kiki"
            elif choice == "8":
                assistantVoice = "Leo"
            save_assistant_voice(assistantVoice)
            tprint(f"Voice set to {assistantVoice}", font="tarty1")    
            speak(f"I'm will now be using {assistantVoice} as my voice.", voice=assistantVoice)
            
            prin("What city are you in?")
            city = input()
            save_city(city)
            
            print("Please type your update command, please include the -y flag: ")
            package_manager = input()
            define_package_manager(package_manager)
    else:
        from assistant import run_assistant
        run_assistant()