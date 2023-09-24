//
//  LocationViewModel.swift
//  AboutTheWeather
//
//  Created by Salvatore Palazzo on 2023-09-23.
//

import Foundation
import CoreLocation

class LocationViewModel: ObservableObject {
    var locality: String
    var currentTemp: String
    var currentConditions: String
    var iconUrlString: String
    
    init(locality: String = "Montreal, QC",
         currentTemp: String = "75°",
         currentConditions: String = "Clear",
         iconUrlString: String = "https://images.freeimages.com/") {
        self.locality = locality
        self.currentTemp = currentTemp
        self.currentConditions = currentConditions
        self.iconUrlString = iconUrlString
    }
}
