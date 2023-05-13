//
//  LocalStorageImpl.swift
//  WeatherApp
//
//  Created by admin_user on 12/05/23.
//

import Foundation



final class LocalStorageImpl : LocalStorage{
    
    let kCitiesKey = "kCitiesKey"
    let kWeatherKey = "kWeatherKey"

    func saveWeather(_ city: CityEntity, _ weather : WeatherInfoEntity){
        guard  let encoded = try? PropertyListEncoder().encode(weather) else { return }
        let key = kWeatherKey + city.getKeyId()

        UserDefaults.standard.set(encoded, forKey: key)
        UserDefaults.standard.synchronize()
    }
 
    func saveCitySearch(_ q: String, _ cities: [CityEntity]){
        guard let encoded = try? PropertyListEncoder().encode(cities) else { return }
        
        UserDefaults.standard.set(encoded, forKey: kCitiesKey + q)
     }

    func getCities(_ q: String) -> [CityEntity]? {
        
        guard let data = UserDefaults.standard.data(forKey: kCitiesKey + q),
              let cities = try? PropertyListDecoder().decode([CityEntity].self, from: data)
        else {
            return nil
        }

        return cities
    }

    func getWeather(_ city: CityEntity) -> WeatherInfoEntity? {
       
        let key = kWeatherKey + city.getKeyId()
        guard let data = UserDefaults.standard.data(forKey: key),
              let weather_info = try? PropertyListDecoder().decode(WeatherInfoEntity.self, from: data)
        else {
            return nil
        }

        return weather_info
        
    }
}
