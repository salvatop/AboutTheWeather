//
//  LocationViewModel.swift
//  AboutTheWeather
//
//  Created by Salvatore Palazzo on 2023-09-23.
//

import Foundation

class LocationViewModel: ObservableObject {
    var location: String = "Montreal, QC"
    var currentTemp: String = "75°"
    var currentConditions: String = "Clear"
    var iconURLString = "https://images.freeimages.com/"
}
