//
//  LocationViewModel.swift
//  AboutTheWeather
//
//  Created by Salvatore Palazzo on 2023-09-23.
//

import Foundation
import CoreLocation

class LocationViewModel: ObservableObject {
    var latitude: Double = 0
    var longitude: Double = 0
    var city: String = "Montreal, QC"
    var currentTemp: String = "75°"
    var currentConditions: String = "Clear"
    var iconUrlString = "https://images.freeimages.com/"
}
