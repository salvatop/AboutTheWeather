//
//  LoggerExtensions.swift
//  AboutTheWeather
//
//  Created by Salvatore Palazzo on 2023-09-23.
//

import OSLog

extension Logger {
    private static var subsystem = Bundle.main.bundleIdentifier!
    
    static let network = Logger(subsystem: subsystem, category: "api-errors")
}
