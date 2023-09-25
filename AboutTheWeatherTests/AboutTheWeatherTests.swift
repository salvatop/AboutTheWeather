//
//  AboutTheWeatherTests.swift
//  AboutTheWeatherTests
//
//  Created by Salvatore Palazzo on 2023-09-23.
//

import XCTest
@testable import AboutTheWeather

final class AboutTheWeatherTests: XCTestCase {
    
    var viewModel: WeatherViewModel!
    var networkManager: NetworkManager!
    
    override func setUpWithError() throws {
        viewModel = WeatherViewModel()
        networkManager = NetworkManager()
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
        networkManager = nil
    }
    
    func testWeatherDataFetch() async throws {
        let expectation = XCTestExpectation(description: "Fetch weather data")
        
        let endpoint = Endpoint.withLatitudeAndLongitude("45.5019°", "73.5674°")
        let response = try await networkManager.sendRequest(urlString: endpoint.url,
                                                            mapToDataModel: APIResponse.self)
        switch response {
        case .success(let weatherData):
            XCTAssertNotNil(weatherData)
            XCTAssertEqual(weatherData.lon, 73.5674)
            XCTAssertGreaterThan(weatherData.current.temp, -200)
            XCTAssertNotNil(weatherData.daily.first)

            expectation.fulfill()
        case .failure(let error):
            XCTFail("Failed to fetch weather data: \(error.localizedDescription)")
        }

        await(for: [expectation], timeout: 5.0)
    }
}
