//
//  WeatherViewModel.swift
//  AboutTheWeather
//
//  Created by Salvatore Palazzo on 2023-09-22.
//

import CoreLocation
import Foundation
import SwiftUI
import OSLog

final class WeatherViewModel: ObservableObject {
    @Published var locationData = LocationViewModel()
    @Published var hourlyData: [HourViewModel] = []
    @Published var dailyData: [DayViewModel] = []
    
    init()  {
        fetchLocation()
        Task(priority: .medium) {
            try await fetchData()
        }
    }
    
    func fetchLocation() {
        LocationManager.shared.getLocation { location in
            self.locationData.latitude = location.lat
            self.locationData.longitude = location.lon
            LocationManager.shared.resolveName(for: CLLocation(latitude: location.lat,
                                                               longitude: location.lon)) { city in
                DispatchQueue.main.async {
                    self.locationData.city = city ?? "Current"
                }
            }
        }
    }

    func sendRequest() async throws -> Result<APIResponse, NetworkManager.ApiError> {
        let api = NetworkManager()
        let endpoint = Endpoint.withLatitudeAndLongitude("\(self.locationData.latitude)",
                                                         "\(self.locationData.longitude)").url
        return try await api.sendRequest(urlString: endpoint, mapToDataModel: APIResponse.self)
    }
    
    func fetchData() async throws {
        let response = try await sendRequest()
        
        switch response {
        case .success(let data):
            DispatchQueue.main.async {
                
                self.locationData.currentTemp = "\(Int(data.current.temp))°F"
                self.locationData.currentConditions = data.current.weather.first?.main ?? "-"
                self.locationData.iconUrlString = String.iconUrlString(for: data.current.weather.first?.icon ?? "")
                
                self.hourlyData = data.hourly.compactMap({
                    let data = HourViewModel()
                    data.temp = "\(Int($0.temp))°"
                    data.hour = String.hour(from: $0.dt)
                    data.imageURL = String.iconUrlString(for: $0.weather.first?.icon ?? "")
                    return data
                })
                self.dailyData = data.daily.compactMap({
                    let data = DayViewModel()
                    data.day = String.day(from: $0.dt)
                    data.high = "\($0.temp.max)°F"
                    data.low = "\($0.temp.min)°F"
                    return data
                })
            }
        case .failure(let error): Logger.network.error("\(error.localizedDescription)")
        }
    }
}
