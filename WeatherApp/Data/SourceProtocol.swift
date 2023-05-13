//
//  SourceProtocol.swift
//  WeatherApp
//
//  Created by admin_user on 12/05/23.
//
 
import Foundation

typealias ResultImageEntity =  (Result<Data, Error>) -> Void
typealias ResultCitiesEntity =  (Result<[CityEntity], Error>) -> Void
typealias ResultWeatherEntity =  (Result<WeatherInfoEntity, Error>) -> Void

protocol NetworkManager {
    func loadCitiesData(_ q: String, _ completion: @escaping ResultCitiesEntity)
    func loadWeatherData(_ coords: CoordEntity, _ completion: @escaping ResultWeatherEntity)
    func loadWeatherIcon(_ name: String, _ completion: @escaping ResultImageEntity)
    func resetAll()
 }

