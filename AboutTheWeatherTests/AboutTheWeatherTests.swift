import XCTest
import CoreLocation
@testable import AboutTheWeather

final class AboutTheWeatherTests: XCTestCase {
    
    var viewModel: WeatherViewModel!
    var mockNetworkManager: MockNetworkManager!
    var mockLocationManager: LocationManager!
    var info: [Info]!
    var current: Current!
    var hourly: [HourModel]!
    var daily: [DayModel]!
    var mockResponse: APIResponse!
    
    let mockLocation = CLLocation(latitude: 37.3349, longitude: -122.0090)
   
    
    override func setUp() {
        super.setUp()
        
        info = [Info(id: 43, main: "Clouds", description: "", icon: "02d")]
        current = Current(temp: 25.0, weather: info)
        hourly = [HourModel(dt: 1635517184, temp: 22.0, weather: info)]
        daily = [DayModel(dt: 1635517184, temp: Temp(min: 20.0, max: 28.0))]
        mockResponse = APIResponse(lat: 45.5019, lon: 73.5674, current: current, hourly: hourly, daily: daily)
        
        mockNetworkManager = MockNetworkManager()
        mockLocationManager = LocationManager()
        
        viewModel = WeatherViewModel(networkManager: mockNetworkManager, locationManager: mockLocationManager)
    }

    override func tearDown() {
        viewModel = nil
        mockNetworkManager = nil
        mockLocationManager = nil
        info = nil
        current = nil
        hourly = nil
        daily = nil
        mockResponse = nil
        super.tearDown()
    }
    
    func testFetchWeatherData() {
        let expectation = self.expectation(description: "Weather data fetch")
        
        mockLocationManager.location = mockLocation
        mockNetworkManager.sendRequestResult = .success(mockResponse)
        
        viewModel.fetchWeatherData()
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            XCTAssertEqual(self.viewModel.locationData.currentTemp, "25°C")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5)
    }


    func testFetchWeatherDataWithError() {
        let expectation = self.expectation(description: "Weather data fetch with error")

        mockLocationManager.location = mockLocation
        mockNetworkManager.sendRequestResult = .failure(NetworkManager.ApiError.serverError(code: 500))

        viewModel.fetchWeatherData()

        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            XCTAssertEqual(self.viewModel.locationData.locality, "Failed to fetch weather data!")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5) 
    }
}
