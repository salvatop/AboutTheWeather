import SwiftUI

@main
struct SwiftUIWeatherApp: App {
    var body: some Scene {
        WindowGroup {
            let networkManager = NetworkManager()
            let locationManager = LocationManager()
            let viewModel = WeatherViewModel(networkManager: networkManager as NetworkManagerProtocol,
                                             locationManager: locationManager as LocationManagerProtocol)
            ContentView().environmentObject(viewModel)
        }
    }
}
