//
//  WeatherAppTests.swift
//  WeatherAppTests
//
//  Created by admin_user on 12/05/23.
//

import XCTest
@testable import WeatherApp

final class WeatherAppTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
 
    func testLoadListOfCities(){
        let data_for_testing = "Zocca"
        
        let networkManager = NetworkManagerImpl()
        let localStorageManager = LocalStorageImpl()
        let viewModel = ViewModelCities(networkManager: networkManager, localStorageManager: localStorageManager)
        
        let exp1 = expectation(description: "testLoadListOfCities")
 
        viewModel.onCitiesLoadedError = { error_line in
            print("testLoadListOfCities error description: ", error_line)
            XCTAssert(error_line != "")
            exp1.fulfill()
        }
        
        viewModel.onCitiesLoaded = {
            let n = viewModel.getNumberOfLoadedCities()
            print("onCitiesLoaded number of cities: ", n)
            XCTAssert(n > 0)
            exp1.fulfill()
        }
        
        viewModel.loadCities(data_for_testing)
        wait(for: [exp1], timeout: 2)
         
    }
       
    func testLoadWeatherInfo(){
        let data_for_testing = CityEntity(name: "Zocca", lat: 44.34, lon: 10.99, country: "IT")
 
        let networkManager = NetworkManagerImpl()
        let localStorageManager = LocalStorageImpl()
        let viewModel = ViewModelWeather(networkManager: networkManager, localStorageManager: localStorageManager, city: data_for_testing)
        
        let exp1 = expectation(description: "testLoadWeatherInfo")
 
        viewModel.onWeatherLoadError = { error_line in
            print("onWeatherLoadError error description: ", error_line)
            XCTAssert(error_line != "")
            exp1.fulfill()
        }
        
        viewModel.onWeatherLoaded = {
            let cityName = viewModel.getNameOfCity()
            print("onWeatherLoaded city:\n", cityName ?? "")
            XCTAssert(cityName != nil)
            XCTAssert(!cityName!.isEmpty)

             let info = viewModel.getWeatherInfo()
            print("onWeatherLoaded info: ", info)
            XCTAssert(!info.isEmpty)

            
            let date = viewModel.getLastUpdateDate()
            print("onWeatherLoaded date: ", date)
            XCTAssert(!date.isEmpty)

            exp1.fulfill()
        }
        
        viewModel.loadWeatherInfo()
        wait(for: [exp1], timeout: 2)
         
        let exp2 = expectation(description: "testLoadWeatherIcon")
 
        viewModel.onIconDataLoaded = {
            let img = viewModel.getIconUIImage()
            print("testLoadWeatherIcon  img != nil : ", img != nil)
            XCTAssert(img != nil)
            exp2.fulfill()
        }
        
        viewModel.loadWeatherImage()
        wait(for: [exp2], timeout: 2)
 
    }
    
    
}
