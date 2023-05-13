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
    private var icon: UIImage?
    private var weatherInfo: WeatherInfoEntity?
 
    
    // MARK: -

    var onWeatherLoaded: onInfoCompletion?
    var onWeatherLoadError: onErrorCompletion?
    var onIconDataLoaded: onInfoCompletion?

    
    // MARK: - Initializer
    init(networkManager: NetworkManager, city: CityEntity) {
        self.networkManager = networkManager
        self.city = city
        self.weatherInfo = nil
     }
    
    func getWeatherInfo() -> String {
        
        guard let weatherInfo = weatherInfo,
              let weather_description = weatherInfo.weather.first else {  return "" }
        let weather_main = weatherInfo.main

        var answer = weather_description.description.capitalized + "\n"
        answer += "Temperature" + " = \(weather_main.temp)\n"
        answer += "Min temperature" + " = \(weather_main.temp_max)\n"
        answer += "Min temperature" + " = \(weather_main.temp_min)\n"
        answer += "Feels like" + " = \(weather_main.feels_like)\n"
        answer += "Pressure" + " = \(weather_main.pressure)\n"
        answer += "Humidity" + " = \(weather_main.humidity)\n"
        answer += "Visibility" + " = \(weatherInfo.visibility)"
 
        return answer
    }

    func getNameOfCity() -> String{
        return city.name
    }
    func getIconUIImage() -> UIImage? {
        return icon
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
    
    func loadWeatherImage()   {
        guard let icon_name = weatherInfo?.weather.first?.icon else { return }

        let handler : ResultImageEntity = { result in
            DispatchQueue.main.async{ [weak self] in
                switch result {
                case .success(let image_data) :
                    self?.icon = UIImage(data: image_data)
                    self?.onIconDataLoaded?()
                case .failure(_) :
                    //TODO: - do smth, if there is no icon
                    break
                }
            }
        }
        
        networkManager.loadWeatherIcon(icon_name, handler)
    }
    
    
    func resetAndClean(){
        networkManager.resetAll()
    }
 
}
    




