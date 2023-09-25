import CoreLocation
import Foundation
import SwiftUI
import os.log

final class WeatherViewModel: ObservableObject {
    @Published var locationData = LocationViewModel()
    @Published var hourlyData: [HourViewModel] = []
    @Published var dailyData: [DayViewModel] = []

    private var locality: String?
    private var networkManager: NetworkManagerProtocol
    private var locationManager: LocationManagerProtocol

    init(networkManager: NetworkManagerProtocol, locationManager: LocationManagerProtocol) {
        self.networkManager = networkManager
        self.locationManager = locationManager
        fetchWeatherData()
    }

    func fetchWeatherData() {
        guard let location = locationManager.location else { return }

        Task(priority: .high) {
            do {
                self.locality = try await locationManager.getPlacemarks(forLocation: location).first?.locality
                try await self.fetchDataForLocation(location)
            } catch {
                os_log("Error fetching weather data: %@", log: .default, type: .error, error.localizedDescription)
            }
        }
    }

    private func sendRequest(endpoint: Endpoint) async throws -> Result<APIResponse, NetworkManager.ApiError> {
        return try await networkManager.sendHTTPRequest(urlString: endpoint.url, mapToDataModel: APIResponse.self)
    }

    private func fetchDataForLocation(_ location: CLLocation) async throws {
        let endpoint = Endpoint.withLatitudeAndLongitude("\(location.coordinate.latitude)", "\(location.coordinate.longitude)")
        let response = try await sendRequest(endpoint: endpoint)

        switch response {
        case .success(let data): updateWeatherData(with: data)
        case .failure(let error):
            locationData.locality = "Failed to fetch weather data!"
            os_log("Weather data request failed: %@", log: .default, type: .error, error.localizedDescription)
        }
    }

    private func updateWeatherData(with data: APIResponse) {
        DispatchQueue.main.async { [weak self] in
            self?.locationData = LocationViewModel(
                locality: self?.locality ?? "",
                currentTemp: "\(Int(data.current.temp))°C",
                currentConditions: data.current.weather.first?.main ?? "-",
                iconUrlString: String.iconUrlString(for: data.current.weather.first?.icon ?? "")
            )

            self?.hourlyData = data.hourly.compactMap({
                return HourViewModel(
                    temp: "\(Int($0.temp))°",
                    hour: String.hour(from: $0.dt),
                    imageURL: String.iconUrlString(for: $0.weather.first?.icon ?? "")
                )
            })

            self?.dailyData = data.daily.compactMap({
                return DayViewModel(
                    day: String.day(from: $0.dt),
                    high: "\(Int($0.temp.max))°",
                    low: "\(Int($0.temp.min))°"
                )
            })
        }
    }
}
