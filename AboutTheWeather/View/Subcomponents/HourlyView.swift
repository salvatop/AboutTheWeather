//
//  HourlyView.swift
//  AboutTheWeather
//
//  Created by Salvatore Palazzo on 2023-09-22.
//

import SwiftUI

struct HourlyView: View {
    @EnvironmentObject var viewModel: WeatherViewModel

    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(viewModel.hourlyData) { model in
                    HourView(model: model)
                }
            }
        }
    }
}

struct HourView: View {
    var model: HourViewModel

    var body: some View {
        VStack {
            AsyncImage(url: URL(string: model.imageURL)!) { image in
                image
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                Image(systemName: "cloud.sun.fill")
            }
            .frame(width: 35, height: 35, alignment: .center)

            Text(model.temp)
                .bold()
                .foregroundColor(.white)

            Text(model.hour)
                .foregroundColor(.white)
        }
        .padding()
    }
}

struct HourlyView_Previews: PreviewProvider {
    static var previews: some View {
        HourlyView()
    }
}
