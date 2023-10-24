import SwiftUI

struct LocationView: View {
    @StateObject var viewModel: WeatherViewModel

    var body: some View {
        VStack(spacing: -15) {
            Text(viewModel.locationData.locality)
                .bold()
                .foregroundColor(.white)
                .font(.system(size: 36))
                .padding()
            AsyncImage(url: URL(string: viewModel.locationData.iconUrlString)) { image in
                image
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                ProgressView()
            }
                .frame(width: 220, height: 220, alignment: .center)
            Text(viewModel.locationData.currentTemp)
                .bold()
                .foregroundColor(.white)
                .font(.system(size: 90))
                .padding()

            Text(viewModel.locationData.currentConditions)
                .bold()
                .foregroundColor(.white)
                .font(.system(size: 45))
                .padding()
        }
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        LocationView(viewModel: WeatherViewModel(networkManager: NetworkManager() as NetworkManagerProtocol,
                                                 locationManager: LocationManager() as LocationManagerProtocol))
    }
}
