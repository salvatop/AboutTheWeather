//
//  DateFormatterExtensions.swift
//  AboutTheWeather
//
//  Created by Salvatore Palazzo on 2023-09-23.
//

import Foundation

extension DateFormatter {
    static let hourFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeZone = .current
        formatter.locale = .current
        formatter.dateFormat = "ha"
        return formatter
    }()

    static let dayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeZone = .current
        formatter.locale = .current
        formatter.dateFormat = "EEEE"
        return formatter
    }()
}
