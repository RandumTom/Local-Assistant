INTENTS = [
    (r"what time is it",                    "get_time"),
    (r"what ('s| is) (today's ) ? date",    "get_date"),
    (r"what time and date",                 "get_time_and_date"),
    (r"weather in (.+)",                    "get_weather"),
    (r"what('s| is) the weather",           "get_weather"),
    (r"update (the )?system",               "update_system"),
]