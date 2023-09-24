//
//  AboutTheWeatherTests.swift
//  AboutTheWeatherTests
//
//  Created by little-ac on 2023-09-23.
//

import XCTest
@testable import AboutTheWeather

class WeatherAppTests: XCTestCase {
    
    final class AboutTheWeatherTests: XCTestCase {
        
        var viewModel: WeatherViewModel!
        
        override func setUpWithError() throws {
            viewModel = WeatherViewModel()
        }
        
        override func tearDownWithError() throws {
            viewModel = nil
        }
        
        func testWeatherDataFetch() async throws {
            let expectation = XCTestExpectation(description: "Fetch weather data")
            let endpoint = Endpoint.withLatitudeAndLongitude("45.5019°", "73.5674°")
            try await viewModel.fetchDataForLocation(from: endpoint)
            
            XCTAssertNotNil(viewModel.hourlyData)
            XCTAssertNotNil(viewModel.dailyData)
            XCTAssertNotNil(viewModel.locationData)
        
            expectation.fulfill()
            wait(for: [expectation], timeout: 5.0)
        }
    }
}
