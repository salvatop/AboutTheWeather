import SwiftUI

struct HourlyView: View {
    @StateObject var viewModel: WeatherViewModel

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
                ProgressView()
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
        HourlyView(viewModel: WeatherViewModel(networkManager: NetworkManager() as NetworkManagerProtocol,
                                               locationManager: LocationManager() as LocationManagerProtocol))
    }
}
