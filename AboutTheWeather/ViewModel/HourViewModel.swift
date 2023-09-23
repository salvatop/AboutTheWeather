//
//  HourViewModel.swift
//  AboutTheWeather
//
//  Created by Salvatore Palazzo on 2023-09-23.
//

import Foundation

class HourViewModel: ObservableObject, Identifiable {
    var id = UUID()
    var temp = String()
    var hour = String()
    var imageURL = String()
}
