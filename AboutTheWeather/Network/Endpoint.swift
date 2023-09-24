//
//  Endpoint.swift
//  AboutTheWeather
//
//  Created by Salvatore Palazzo on 2023-09-23.
//

enum Endpoint {
    private var baseURL: String { return "https://api.openweathermap.org/data/2.5/weather?" }
    private var params: String { return "&exclude=minutely&units=imperial" }
    private var apiKey: String { return "&appid=APIKEY" }

    case withLatitudeAndLongitude(String, String)
   
    var url: String {
        var location: String

        switch self {
        case .withLatitudeAndLongitude(let lat, let lon): location = "lat=\(lat)&lon=\(lon)"
        }
        return baseURL + location + params + apiKey
    }
}
