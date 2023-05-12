//
//  Models.swift
//  WeatherApp
//
//  Created by admin_user on 12/05/23.
//
 

import Foundation

struct CityEntity: Codable {
    let name: String
    let lat: Double
    let lon: Double
}

struct WeatherInfoEntity: Codable {
    let coord: CoordEntity
    let weather: [WeatherEntity]
    let main : MainEntity
    let visibility : Double
    let wind : WindEntity
 }
 
struct CoordEntity: Hashable, Codable {
    let lat: Double
    let lon: Double
}

struct WeatherEntity: Codable {
    let id : Int
    let main : String
    let description : String
    let icon : String
}

struct MainEntity: Codable {
    let temp : Double
    let feels_like : Double
    let temp_min : Double
    let temp_max : Double
    let pressure : Double
    let humidity : Double
    let sea_level : Double
    let grnd_level : Double
}

struct WindEntity: Codable {
    let speed : Double
    let deg : Double
    let gust : Double
}
 