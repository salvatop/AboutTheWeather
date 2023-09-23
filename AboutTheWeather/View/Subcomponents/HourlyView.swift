//
//  HourlyView.swift
//  AboutTheWeather
//
//  Created by Salvatore Palazzo on 2023-09-22.
//

import SwURL
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
            // image, temp, hour
            SwURLImage(
                url: URL(string: model.imageURL)!,
                placeholderImage: Image(systemName: "cloud.sun.fill"),
                transition: .none
            )
            .imageProcessing({ image in
                return image
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 35, height: 35, alignment: .center)

            })

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
            .preferredColorScheme(.dark)
    }
}
