import Foundation
import CoreLocation
import OSLog

/// A class responsible for managing location-related functionality.
final class LocationManager: NSObject, CLLocationManagerDelegate {
    var locationManager = CLLocationManager()
   
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
     /// Retrieves placemarks for a given location asynchronously.
     ///
     /// - Parameters:
     ///   - location: The `CLLocation` object representing the location for which placemarks are to be retrieved.
     /// - Returns: An array of `CLPlacemark` objects representing the placemarks for the location.
     /// - Throws: An error if there is an issue with reverse geocoding.
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
