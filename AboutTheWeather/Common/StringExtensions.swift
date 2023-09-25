import Foundation

extension String {
    static func hour(from dt: Float) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(dt))
        return DateFormatter.hourFormatter.string(from: date)
    }

    static func day(from dt: Float) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(dt))
        return DateFormatter.dayFormatter.string(from: date)
    }
}

extension String {
    static func iconUrlString(for iconCode: String) -> String {
        return "https://openweathermap.org/img/wn/\(iconCode)@4x.png"
    }
}

