//
//  LocationManager.swift
//  AboutTheWeather
//
//  Created by Salvatore Palazzo on 2023-09-22.
//

import Foundation
import CoreLocation

final class LocationManager: NSObject, CLLocationManagerDelegate {
    static let shared = LocationManager()

    let manager = CLLocationManager()

    var completion: (((lon: Double, lat: Double)) -> Void)?

    func getLocation(completion: (((lon: Double, lat: Double)) -> Void)?) {
        self.completion = completion
        manager.requestWhenInUseAuthorization()
        manager.delegate = self
        manager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        manager.stopUpdatingLocation()
        completion?((lon: location.coordinate.longitude, lat: location.coordinate.latitude))
    }

    func resolveName(for location: CLLocation, completion: @escaping (String?) -> Void) {
        let coder = CLGeocoder()
        coder.reverseGeocodeLocation(location) { places, error in
            guard let place = places?.first, error == nil else { return }

            var name = String()

            if let city = place.locality {
                name = city
            }

            if let region = place.administrativeArea {
                name += ", \(region)"
            }
            completion(name)
        }
    }
}
