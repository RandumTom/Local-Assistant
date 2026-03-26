import datetime

def ordinal(day):
    if 11 <= day <= 13:
        return f"{day}th"
    suffix = {1: "st", 2: "nd", 3: "rd"}
    return f"{day}{suffix.get(day % 10, 'th')}"

def get_time():
    time = datetime.datetime.now().time()
    return f"It's currently {time.strftime('%H:%M')}"

def get_date():
    date = datetime.datetime.now()
    return f"Today is the {ordinal(date.day)} of {date.strftime('%B')}"

def get_time_and_date():
    return f"{get_time()} and {get_date()}"

if __name__ == "__main__":
    print(get_time())
    print(get_date())
    print(get_time_and_date())