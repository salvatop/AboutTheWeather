//
//  ContentView.swift
//  AboutTheWeather
//
//  Created by Salvatore Palazzo on 2023-09-22.
//

import SwiftUI

struct ContentView: View {

    @EnvironmentObject var viewModel: WeatherViewModel

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, Color(.link), .orange]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)

            ScrollView {
                VStack {
                    HeaderView()
                    HourlyView()
                    DailyView()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
