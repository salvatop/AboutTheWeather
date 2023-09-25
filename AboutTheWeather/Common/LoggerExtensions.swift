import OSLog

extension Logger {
    private static var subsystem = Bundle.main.bundleIdentifier!
    
    static let network = Logger(subsystem: subsystem, category: "api-errors")
}
