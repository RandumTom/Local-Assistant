# Import the module.
import python_weather

import asyncio


async def main() -> None:
  
  # Declare the client. The measuring unit used defaults to the metric system (celcius, km/h, etc.)
  async with python_weather.Client(unit=python_weather.IMPERIAL) as client:
    
    # Fetch a weather forecast from a city.
    weather = await client.get('New York')
    
    # Fetch the temperature for today.
    print(weather.temperature)
    
    # Fetch weather forecast for upcoming days.
    for daily in weather:
      print(daily)
    
      # Each daily forecast has their own hourly forecasts.
      for hourly in daily:
        print(f' --> {hourly!r}')

if __name__ == '__main__':
  asyncio.run(main())