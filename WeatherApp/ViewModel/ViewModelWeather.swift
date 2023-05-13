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
    private var coords: CoordEntity
    private var weatherInfo: WeatherInfoEntity?
 
    
    // MARK: -

    var onWeatherLoaded: onInfoCompletion?
    var onWeatherLoadError: onErrorCompletion?

    
    // MARK: - Initializer
    init(networkManager: NetworkManager, coords : CoordEntity) {
        self.networkManager = networkManager
        self.coords = coords
        self.weatherInfo = nil
     }
    
    // MARK: - Public
   
    func loadWeatherInfo()   { 
        
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
    




