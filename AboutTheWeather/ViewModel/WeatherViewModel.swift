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
    
    private var locality: String?
    
    init()  {
        Task(priority: .medium) {
            try await fetchLocation()
        }
    }

    func fetchLocation() async throws  {
        let locationManager = LocationManager()
        guard let location = locationManager.locationManager.location else { return }
     
        locality = try await locationManager.getPlacemarks(forLocation: location).first?.locality
        
        let endpoint = Endpoint.withLatitudeAndLongitude("\(location.coordinate.latitude)",
                                                         "\(location.coordinate.longitude)")
        try await fetchDataForLocation(from: endpoint)
    }

    func sendRequest(endpoint: Endpoint) async throws -> Result<APIResponse, NetworkManager.ApiError> {
        let api = NetworkManager()
        return try await api.sendRequest(urlString: endpoint.url, mapToDataModel: APIResponse.self)
    }
    
    func fetchDataForLocation(from endpoint: Endpoint) async throws {
        let response = try await sendRequest(endpoint: endpoint)
        
        switch response {
        case .success(let data):
            DispatchQueue.main.async { [weak self] in
                self?.locationData = LocationViewModel(locality: self?.locality ?? "",
                                                      currentTemp: "\(Int(data.current.temp))°F",
                                                      currentConditions: data.current.weather.first?.main ?? "-",
                                                       iconUrlString: String.iconUrlString(for: data.current.weather.first?.icon ?? ""))
               
                self?.hourlyData = data.hourly.compactMap({
                    return HourViewModel(temp: "\(Int($0.temp))°",
                                         hour: String.hour(from: $0.dt),
                                         imageURL: String.iconUrlString(for: $0.weather.first?.icon ?? ""))
                })
                self?.dailyData = data.daily.compactMap({
                    return DayViewModel(day: String.day(from: $0.dt),
                                        high: "\($0.temp.max)°F",
                                        low: "\($0.temp.min)°F")
                })
            }
        case .failure(let error):
            Logger.network.error("\(error.localizedDescription)")
        }
    }
}
