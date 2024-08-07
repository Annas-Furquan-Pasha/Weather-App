# weather_app

A new Flutter project 

## Getting Started

- This User friendly app is used to get details of the weather in a particular city
- Weather details are taken from an api called OpenWeatherMap api
- The details shown are :
  - City Name
  - Temperature (in celsius)
  - Humidity Percentage
  - Wind Speed in meter per second 
  - weather condition
  - an icon representing weather condition
- A refresh icon is also added to get updated weather details.
- The user can refresh for every 10 seconds

## Build Details

- This app is made completely with flutter(version : 3.22.2, dart version : 3.4.3) and android studio
- For state management 'flutter_riverpod (version : 2.5.1)' package is used
- For getting information from api 'http (version : 1.2.1)' package is used
- For storing recent history in device 'sqflite (version : 2.3.3+1)' package is used

## How to Use

For using this app 
- The user should have vs code or android studio installed in their device
- Clone this repository in local device and open the file using vs code or android studio
- Run command 'flutter pub get' to download the dependencies in the terminal
- For running in real device connect device with usb debugging option as 'ON' then run the file to get the app on their device
- For running in emulator create an emulator and run the file in that emulator

