import SwiftUI

struct DailyView: View {
    @StateObject var viewModel: WeatherViewModel

    var body: some View {
        VStack {
            ForEach(viewModel.dailyData) { model in
                DayRowView(model: model)
                    .padding()
            }
        }
    }
}

struct DayRowView: View {
    var model: DayViewModel

    var body: some View {
        HStack {
            Text(model.day)
                .bold()
                .font(.system(size: 26))
                .foregroundColor(.white)

            Spacer()

            VStack {
                Text("H: \(model.high)")
                    .foregroundColor(.white)
                Text("L: \(model.low)")
                    .foregroundColor(.white)
            }
        }
    }
}

struct DailyView_Previews: PreviewProvider {
    static var previews: some View {
        DailyView(viewModel: WeatherViewModel(networkManager: NetworkManager() as NetworkManagerProtocol,
                                                locationManager: LocationManager() as LocationManagerProtocol))
    }
}
