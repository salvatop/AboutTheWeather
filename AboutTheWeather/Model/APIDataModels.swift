import Foundation

struct APIResponse: Decodable {
    let lat: Double
    let lon: Double
    let current: Current
    let hourly: [HourModel]
    let daily: [DayModel]
}

struct Current: Decodable {
    let temp: Double
    let weather: [Info]
}

struct HourModel: Decodable {
    let dt: Double
    let temp: Double
    let weather: [Info]
}

struct Info: Decodable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct DayModel: Decodable {
    let dt: Double
    let temp: Temp
}

struct Temp: Decodable {
    let min: Double
    let max: Double
}
