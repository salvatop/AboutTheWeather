[![CodeQL](https://github.com/salvatop/AboutTheWeather/workflows/CodeQL/badge.svg)](https://github.com/salvatop/AboutTheWeather/actions?query=workflow%3ACodeQL)
[![GitHub Issues](https://img.shields.io/github/issues-raw/salvatop/AboutTheWeather)](https://github.com/salvatop/AboutTheWeather/issues)
[![Total Commits](https://img.shields.io/github/last-commit/salvatop/AboutTheWeather)](https://github.com/salvatop/AboutTheWeather/commits)
[![GitHub commit activity](https://img.shields.io/github/commit-activity/4w/salvatop/AboutTheWeather?foo=bar)](https://github.com/salvatop/AboutTheWeather/commits)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/salvatop/AboutTheWeather/blob/main/LICENSE)
![Contributions welcome](https://img.shields.io/badge/contributions-welcome-orange.svg)

# About The Weather

<img align="left" width="200" height="66" src="weather.png">

A single-screen weather app written in Swift/SwiftUI that follows a Model-View-ViewModel (MVVM) architecture, 
which helps maintain separation of concerns and ensures a clean and scalable codebase. <br> <br>
 
## Here's an overview of the architecture

1. Model:<br>
**API Data Model** : Represents the structure of weather data, including properties like temperature, humidity, wind speed, weather conditions, etc. This model is used to decode data from the weather API. <br>

2. ViewModel:<br>
**WeatherViewModel** : Acts as an intermediary between the Model and View layers. Also responsible for making API requests to fetch weather data from the weather service provider OpenWeatherMap and formats it for presentation.<br></br>
**LocationViewModel**: Manages location services, retrieving the user's current location and passing it to the WeatherViewModel for weather data retrieval. <br>

3. View:<br>
**ContentView** : This is the main SwiftUI view that presents the weather information to the user.</br>
**Subcomponents** : SwiftUI Views

4. Service:<br>
**Location Service** : Interacts with the device's location services to fetch the user's current location.</br>

5. Common:<br>
This contains reauseble tools shared app wise, like extensions, helper functions, etc.</br>

5. Network:<br>
**Endpoint** : url used to call the open weather API, which contains the configuable parameter and the APIKey.</br>
**NetworkManager** : network layer with generic functions to make http calls and map data to data models

## Usage
Get the API key from [<img width="100" height="40" src="open_weather_logo.png">](https://openweathermap.org/api) and configure it in the [endpoint](https://github.com/salvatop/AboutTheWeather/blob/main/AboutTheWeather/Network/Endpoint.swift) file
</br>
```Swift
enum Endpoint {
    ..
    private var apiKey: String { return "&appid=APIKEY" }
    ..
```
</br>

## How the App looks like?

<p align="center">
  <img width="300" height="600" src="app_screenshot.png">
</p>
