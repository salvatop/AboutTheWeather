import Foundation

/// An enumeration representing different endpoints for the OpenWeatherMap API.
enum Endpoint {
    /// The base URL for the OpenWeatherMap API.
    private var baseURL: String { return "https://api.openweathermap.org/data/3.0/onecall?" }

    /// Common query parameters for the API requests.
    private var params: String { return "&exclude=minutely&units=metric" }

    /// The API key required for accessing the OpenWeatherMap API.
    private var apiKey: String { return "&appid=YOUR_API_KEY_HERE" }

    /// Represents an endpoint that requires latitude and longitude coordinates.
    ///
    /// - Parameters:
    ///   - lat: The latitude coordinate.
    ///   - lon: The longitude coordinate.
    case withLatitudeAndLongitude(String, String)

    /// Computed property to generate the full URL for the endpoint.
    var url: String {
        var location: String

        switch self {
        case .withLatitudeAndLongitude(let lat, let lon):
            location = "lat=\(lat)&lon=\(lon)"
        }

        return baseURL + location + params + apiKey
    }
}
