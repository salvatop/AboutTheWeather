import Foundation
import CoreLocation
import OSLog

protocol LocationManagerProtocol {
    var location: CLLocation? { get }
    func getPlacemarks(forLocation location: CLLocation) async throws -> [CLPlacemark]
}


/// A class responsible for managing location-related functionality.
final class LocationManager: NSObject, CLLocationManagerDelegate, LocationManagerProtocol {
    var location: CLLocation?
    var manager = CLLocationManager()
   
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        self.location = manager.location
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
            Logger.network.log("\(error)")
            throw error
        }
    }
}
