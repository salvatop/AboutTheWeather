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
                    LocationView(viewModel: viewModel)
                    HourlyView(viewModel: viewModel)
                    DailyView(viewModel: viewModel)
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
