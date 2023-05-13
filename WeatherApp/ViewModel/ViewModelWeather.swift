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
    private let localStorageManager: LocalStorage

    private var city: CityEntity
    private var icon: UIImage?
    private var weatherInfo: WeatherInfoEntity?
 
    
    // MARK: -

    var onWeatherLoaded: onInfoCompletion?
    var onWeatherLoadError: onErrorCompletion?
    var onIconDataLoaded: onInfoCompletion?

    
    // MARK: - Initializer
    init(networkManager: NetworkManager, localStorageManager: LocalStorage, city: CityEntity) {
        self.networkManager = networkManager
        self.localStorageManager = localStorageManager
        self.city = city
        self.weatherInfo = nil
     }
    
    func getWeatherInfo() -> String {
        
        guard let weatherInfo = weatherInfo,
              let weather_description = weatherInfo.weather.first else {  return "" }
        let weather_main = weatherInfo.main

        var answer = weather_description.description.capitalized + "\n\n"
        answer += kWeatherView_Temperature + " = \(weather_main.temp)\(kDefaultMeasureUnit)\n\n"
        answer += kWeatherView_Min_temperature + " = \(weather_main.temp_min)\(kDefaultMeasureUnit)\n"
        answer += kWeatherView_Max_temperature + " = \(weather_main.temp_max)\(kDefaultMeasureUnit)\n"
        answer += kWeatherView_Feels_like + " = \(weather_main.feels_like)\(kDefaultMeasureUnit)\n\n"
        answer += kWeatherView_Pressure + " = \(weather_main.pressure) hPa\n"
        answer += kWeatherView_Humidity + " = \(weather_main.humidity)%\n"
        answer += kWeatherView_Visibility + " = \(weatherInfo.visibility) m"
 
        return answer
    }
    
    func getNameOfCity() -> String? {
        var name = kWeatherView_city + ": " + city.name.capitalized
        if let country = city.country  {
            name += "\n" + kWeatherView_country + ": " + country.capitalized 
        }
        return name
    }
 
    func getIconUIImage() -> UIImage? {
        return icon
    }
 
    func getLastUpdateDate() -> String{
        guard let date = weatherInfo?.date else {  return "" }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        let nice_date = dateFormatter.string(from: date)
        return  kWeatherView_LastUpdated + ": " + nice_date
    }
 
    // MARK: - Source load
   
    func loadWeatherInfo()   {
        let city = city
        let coords = CoordEntity(lat: city.lat, lon: city.lon)
        
        let handler : ResultWeatherEntity = { result in
            DispatchQueue.main.async{ [weak self] in
                switch result {
                case .success(var weather) :
                    weather.date = Date()
                    self?.weatherInfo = weather
                    self?.localStorageManager.saveWeather(city, weather)
                    self?.onWeatherLoaded?()
                case .failure(let error as NSError) :
                    switch error.code {
                    case 0 :
                        break
                    case 400...500:
                        if let weather = self?.localStorageManager.getWeather(city){
                            self?.weatherInfo = weather
                            self?.onWeatherLoaded?()
                        } else {
                            fallthrough
                        }
                    default:
                        self?.onWeatherLoadError?(error.localizedDescription)
                    } 
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
    




