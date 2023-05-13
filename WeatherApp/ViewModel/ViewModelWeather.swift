//
//  ViewModelWeather.swift
//  WeatherApp
//
//  Created by admin_user on 12/05/23.
//
 

import Foundation
import UIKit

 
final class ViewModelWeather {
 
    // MARK: - Properties
    private let networkManager: NetworkManager
    private var city: CityEntity
    private var weatherInfo: WeatherInfoEntity?
 
    
    // MARK: -

    var onWeatherLoaded: onInfoCompletion?
    var onWeatherLoadError: onErrorCompletion?

    
    // MARK: - Initializer
    init(networkManager: NetworkManager, city: CityEntity) {
        self.networkManager = networkManager
        self.city = city
        self.weatherInfo = nil
     }
    
    func getNameOfCity() -> String{
        return city.name
    }
    // MARK: - Public
   
    func loadWeatherInfo()   {
        let coords = CoordEntity(lat: city.lat, lon: city.lon)
        
        let handler : ResultWeatherEntity = { result in
            DispatchQueue.main.async{ [weak self] in
                switch result {
                case .success(let weather) :
                    self?.weatherInfo = weather
                    self?.onWeatherLoaded?()
                case .failure(let error_line) :
                    self?.onWeatherLoadError?(error_line.localizedDescription)
                }
            }
        }
        
        networkManager.loadWeatherData(coords, handler)
    }
    
    
    func resetAndClean(){
        networkManager.resetAll()
    }
 
}
    




