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
    
    func testEndpointUrl() async throws {
        let endpoint = Endpoint.withLatitudeAndLongitude("45.5019°", "73.5674°")
        XCTAssertNotNil(endpoint.url)
    }
}
