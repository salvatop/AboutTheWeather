import Foundation
import CoreLocation

final class LocationViewModel: ObservableObject {
    var locality: String
    var currentTemp: String
    var currentConditions: String
    var iconUrlString: String
    
    init(locality: String = String(),
         currentTemp: String = String(),
         currentConditions: String = String(),
         iconUrlString: String = String()) {
        self.locality = locality
        self.currentTemp = currentTemp
        self.currentConditions = currentConditions
        self.iconUrlString = iconUrlString
    }
}
