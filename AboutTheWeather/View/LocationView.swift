//
//  LocationView.swift
//  AboutTheWeather
//
//  Created by Salvatore Palazzo on 2023-09-22.
//

import SwURL
import SwiftUI

struct LocationView: View {
    @EnvironmentObject var viewModel: WeatherViewModel

    var body: some View {
        VStack(spacing: -15) {
            Text(viewModel.locationViewModel.location)
                .bold()
                .foregroundColor(.white)
                .font(.system(size: 36))
                .padding()

            SwURLImage(
                url: URL(string: viewModel.locationViewModel.iconURLString)!,
                placeholderImage: Image(systemName: "cloud.sun.fill"),
                transition: .none
            )
            .imageProcessing({ image in
                return image
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 220, height: 220, alignment: .center)
            })

            Text(viewModel.locationViewModel.currentTemp)
                .bold()
                .foregroundColor(.white)
                .font(.system(size: 90))
                .padding()

            Text(viewModel.locationViewModel.currentConditions)
                .bold()
                .foregroundColor(.white)
                .font(.system(size: 45))
                .padding()
        }
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        LocationView()
            .preferredColorScheme(.dark)
    }
}
