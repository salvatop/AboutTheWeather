//
//  AboutTheWeatherApp.swift
//  AboutTheWeather
//
//  Created by Salvatore Palazzo on 2023-09-22.
//

import SwiftUI

@main
struct SwiftUIWeatherAppApp: App {
    var body: some Scene {
        WindowGroup {
            let viewModel = WeatherViewModel()
            ContentView().environmentObject(viewModel)
        }
    }
}
