//
//  WeatherViewModel.swift
//  AboutTheWeather
//
//  Created by Salvatore Palazzo on 2023-09-22.
//

import CoreLocation
import Foundation
import SwiftUI

final class WeatherViewModel: ObservableObject {
    @Published var locationViewModel = LocationViewModel()
    @Published var hourlyData: [HourData] = []
    @Published var dailyData: [DayData] = []

    init() {
        fetchData()
    }

    func fetchData() {
        // get data and location info

        LocationManager.shared.getLocation { location in
            LocationManager.shared.resolveName(for: CLLocation(latitude: location.lat,
                                                               longitude: location.lon)
            ) { name in
                DispatchQueue.main.async {
                    self.locationViewModel.location = name ?? "Current"
                }
            }
            
            let endpoint = Endpoint.latAndlon("\(location.lat)", "\(location.lon)").url
            guard let url = URL(string: endpoint) else { return }

            let task = URLSession.shared.dataTask(with: url) { data, _, error in
                guard let data = data, error == nil else { return }

                do {
                    let result = try JSONDecoder().decode(APIResponse.self, from: data)

                    DispatchQueue.main.async {
                        // Hourly
                        self.locationViewModel.currentTemp = "\(Int(result.current.temp))°F"
                        self.locationViewModel.currentConditions = result.current.weather.first?.main ?? "-"
                        self.locationViewModel.iconURLString = String.iconUrlString(for: result.current.weather.first?.icon ?? "")
                        // Hourly
                        self.hourlyData = result.hourly.compactMap({
                            let data = HourData()
                            data.temp = "\(Int($0.temp))°"
                            data.hour = String.hour(from: $0.dt)
                            data.imageURL = String.iconUrlString(for: $0.weather.first?.icon ?? "")
                            return data
                        })

                        // Daily
                        self.dailyData = result.daily.compactMap({
                            let data = DayData()
                            data.day = String.day(from: $0.dt)
                            data.high = "\($0.temp.max)°F"
                            data.low = "\($0.temp.min)°F"
                            return data
                        })
                    }

                    return
                }
                catch {
                    print(error)
                }
            }
            task.resume()
        }
    }
}

// MARK: - Location

class LocationViewModel: ObservableObject {
    var location: String = "New York City, NY"
    var currentTemp: String = "75°"
    var currentConditions: String = "Clear"
    var iconURLString = "https://www.apple.com"
}

// MARK: - Hourly

class HourData: ObservableObject, Identifiable {
    var id = UUID()
    var temp = "55ª"
    var hour = "1PM"
    var imageURL = "https://www.apple.com"
}

// MARK: - Daily

class DayData: ObservableObject, Identifiable {
    var id = UUID()
    var day = "Monday"
    var high = "77°F"
    var low = "47°F"
}
