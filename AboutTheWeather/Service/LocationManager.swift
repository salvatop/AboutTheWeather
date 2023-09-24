//
//  LocationManager.swift
//  AboutTheWeather
//
//  Created by Salvatore Palazzo on 2023-09-22.
//

import Foundation
import CoreLocation
import OSLog


final class LocationManager: NSObject, CLLocationManagerDelegate {
    var locationManager = CLLocationManager()
   
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    func getPlacemarks(forLocation location: CLLocation) async throws -> [CLPlacemark] {
        let geocoder = CLGeocoder()
        do {
            let placemarks = try await geocoder.reverseGeocodeLocation(location)
            return placemarks
        } catch {
            throw error
        }
    }
}
