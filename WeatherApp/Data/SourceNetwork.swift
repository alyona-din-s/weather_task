//
//  SourceNetwork.swift
//  WeatherApp
//
//  Created by admin_user on 12/05/23.
//

import Foundation 
import UIKit

final class NetworkManagerImpl: NetworkManager {

   // MARK: - Initializer
   init(){
       setupStart()
   }

   deinit {
       resetAll()
   }


    // MARK: - Protocol
    func loadCitiesData(_ q: String, _ completion: ResultCitiesEntity){
        loadEntitiesData(kSourceCitiesNetworkData + "?q=\(q)&limit=50&appid=\(kAppKey)", completion)

    }
    func loadWeatherData(_ coords: CoordEntity, _ completion: ResultWeatherEntity){
        loadEntitiesData(kSourceWeatherNetworkData + "lat=\(coords.lat)&lon=\(coords.lon)&appid=\(kAppKey)", completion)

    }
 
   func resetAll(){
       URLSession.shared.invalidateAndCancel()
       URLCache.shared.removeAllCachedResponses()
   }
    
    // MARK: - Private

    private func loadEntitiesData<T: Decodable>(_ source: String, _ completion: (Result<T, WeatherError>) -> Void) {
       guard  let url = URL(string: source) else {
           completion(.failure(WeatherError.emptyCityQueryError))
           return
       }
    
       URLSession.shared.dataTask(with: url) { data, response, error in
           guard let data = data, error == nil else {
               completion(.failure(error as? WeatherError ?? WeatherError.noErrorAndEmptyDataError))
               return
           }

           do {
               let decodedResponse = try JSONDecoder().decode(T.self, from: data)
               completion(.success(decodedResponse))
           } catch let errorDecoding {
               completion(.failure(errorDecoding as! WeatherError))
           }
          
       }.resume()
   }
     
   private func setupStart(){
       URLSession.shared.configuration.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
   }
}

