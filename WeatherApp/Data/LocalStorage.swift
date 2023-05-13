//
//  LocalStorage.swift
//  WeatherApp
//
//  Created by admin_user on 12/05/23.
//

import Foundation



final class LocalStorage : LocalSourceProtocol{
    
    let kCitiesKey = "567890"
    let kWeatherKey = "987654"

    func saveWeather(_ weather : WeatherEntity){
        
    }
 
    func saveCitySearch(_ q: String, _ cities: [CityEntity]){
        
    }

    func getCities(_ q: String) -> [CityEntity]? {
        
        guard let data = UserDefaults.standard.data(forKey: kCitiesKey + q),
              let cities = try? PropertyListDecoder().decode([CityEntity].self, from: data)
        else {
            return nil
        }

        return cities
    }

    func getWeather(_ city: CityEntity) -> WeatherEntity? {
       
        let key = kWeatherKey + "\(city.hashValue)"
        guard let data = UserDefaults.standard.data(forKey: key),
              let weather_info = try? PropertyListDecoder().decode(WeatherEntity.self, from: data)
        else {
            return nil
        }

        return weather_info
        
    }
}
