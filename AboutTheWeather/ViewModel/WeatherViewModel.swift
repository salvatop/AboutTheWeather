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
                    self.locationData.location = name ?? "Current"
                }
            }
         
            let endpoint = Endpoint.withLatitudeAndLongitude("\(location.lat)", "\(location.lon)").url
            guard let url = URL(string: endpoint) else { return }

            let task = URLSession.shared.dataTask(with: url) { data, _, error in
                guard let data = data, error == nil else { return }

                do {
                    let result = try JSONDecoder().decode(APIResponse.self, from: data)

                    DispatchQueue.main.async {
                        // Hourly
                        self.locationData.currentTemp = "\(Int(result.current.temp))°F"
                        self.locationData.currentConditions = result.current.weather.first?.main ?? "-"
                        self.locationData.iconURLString = String.iconUrlString(for: result.current.weather.first?.icon ?? "")
                        // Hourly
                        self.hourlyData = result.hourly.compactMap({
                            let data = HourViewModel()
                            data.temp = "\(Int($0.temp))°"
                            data.hour = String.hour(from: $0.dt)
                            data.imageURL = String.iconUrlString(for: $0.weather.first?.icon ?? "")
                            return data
                        })

                        // Daily
                        self.dailyData = result.daily.compactMap({
                            let data = DayViewModel()
                            data.day = String.day(from: $0.dt)
                            data.high = "\($0.temp.max)°F"
                            data.low = "\($0.temp.min)°F"
                            return data
                        })
                    }

                    return
                }
                catch {
                    Logger.network.error("\(error.localizedDescription)")
                }
            }
            task.resume()
        }
    }
}
