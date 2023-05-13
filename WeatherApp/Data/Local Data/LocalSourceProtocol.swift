//
//  LocalSourceProtocol.swift
//  WeatherApp
//
//  Created by admin_user on 13/05/23.
//

import Foundation

protocol LocalStorage {
    
    func saveWeather(_ city: CityEntity, _ weather : WeatherInfoEntity)
    func saveCitySearch(_ q: String, _ cities: [CityEntity])
    
    func getCities(_ q: String) -> [CityEntity]?
    func getWeather(_ city: CityEntity) -> WeatherInfoEntity?
}
