import SwiftUI

@main
struct SwiftUIWeatherAppApp: App {
    var body: some Scene {
        WindowGroup {
            let viewModel = WeatherViewModel()
            ContentView().environmentObject(viewModel)
        }
    }
}
