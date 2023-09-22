//
//  HeaderView.swift
//  AboutTheWeather
//
//  Created by Salvatore Palazzo on 2023-09-22.
//

import SwURL
import SwiftUI

struct HeaderView: View {
    @EnvironmentObject var viewModel: WeatherViewModel

    var body: some View {
        VStack(spacing: -15) {
            Text(viewModel.headerViewModel.location)
                .bold()
                .foregroundColor(.white)
                .font(.system(size: 36))
                .padding()

            SwURLImage(
                url: URL(string: viewModel.headerViewModel.iconURLString)!,
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

            Text(viewModel.headerViewModel.currentTemp)
                .bold()
                .foregroundColor(.white)
                .font(.system(size: 90))
                .padding()

            Text(viewModel.headerViewModel.currentConditions)
                .bold()
                .foregroundColor(.white)
                .font(.system(size: 45))
                .padding()
        }
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView()
            .preferredColorScheme(.dark)
    }
}
