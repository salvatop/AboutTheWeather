//
//  DayViewModel.swift
//  AboutTheWeather
//
//  Created by Salvatore Palazzo on 2023-09-23.
//

import Foundation

class DayViewModel: ObservableObject, Identifiable {
    var id = UUID()
    var day = String()
    var high = String()
    var low = String()
}
