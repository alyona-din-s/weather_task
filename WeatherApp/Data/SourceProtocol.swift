//
//  SourceProtocol.swift
//  WeatherApp
//
//  Created by admin_user on 12/05/23.
//
 
import Foundation

typealias ResultCitiesEntity =  (Result<[CityEntity], WeatherError>) -> Void
typealias ResultWeatherEntity =  (Result<WeatherInfoEntity, WeatherError>) -> Void

protocol NetworkManager {
    func loadCitiesData(_ q: String, _ completion: @escaping ResultCitiesEntity)
    func loadWeatherData(_ coords: CoordEntity, _ completion: @escaping ResultWeatherEntity)
    func resetAll()
 }

