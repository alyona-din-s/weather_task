//
//  SourceStatic.swift
//  WeatherApp
//
//  Created by admin_user on 12/05/23.
//

import Foundation
import UIKit


final class NetworkManagerMock: NetworkManager {
 
    
    // MARK: - Protocol
    func loadCitiesData(_ q: String, _ completion: @escaping ResultCitiesEntity  ){
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            let listCitiesSample = self.loadCitiesSamplesArray(100)
            completion(.success(listCitiesSample))
        }
    }

    func loadWeatherData(_ coords: CoordEntity, _ completion: @escaping ResultWeatherEntity ){
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
            let weatherSample = self.loadOneCityWeatherSample(coords)
            completion(.success(weatherSample))
        }
    }
     
    //MARK: - private fill
    private func loadCitiesSamplesArray(_ count: Int) -> [CityEntity] {
        var array = [CityEntity]()
        for i in 0..<count {
            array.append(loadOneCitySample(i))
        }
        return array
    }
    
    private func loadOneCitySample(_ ind : Int) -> CityEntity {
        let line = """
      {
        "name": "city_\(ind)",
        "lat": \(Double.random(in: -100...100)),
        "lon": \(Double.random(in: -100...100))
      }
    """
 
        let data = line.data(using: .utf8)!
        return try! JSONDecoder().decode(CityEntity.self, from: data)
    }
    
    private func loadOneCityWeatherSample(_ coords: CoordEntity) -> WeatherInfoEntity {
        
        let line = """
    {
      "coord": {
        "lon": \(coords.lon),
        "lat": \(coords.lat)
      },
      "weather": [
        {
          "id": 501,
          "main": "Rain",
          "description": "moderate rain",
          "icon": "10d"
        }
      ],
      "main": {
        "temp": 298.48,
        "feels_like": 298.74,
        "temp_min": 297.56,
        "temp_max": 300.05,
        "pressure": 1015,
        "humidity": 64,
        "sea_level": 1015,
        "grnd_level": 933
      },
      "visibility": 10000,
      "wind": {
        "speed": 0.62,
        "deg": 349,
        "gust": 1.18
      }
    }
    """
 
        let data = line.data(using: .utf8)!
        return try! JSONDecoder().decode(WeatherInfoEntity.self, from: data)
     }
    
    
    func resetAll(){
        
    }
}



