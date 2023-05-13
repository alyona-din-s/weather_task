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
    func loadCitiesData(_ q: String, _ completion: @escaping ResultCitiesEntity){
        let request_line = kSourceCitiesNetworkData + "?q=\(q)&limit=50&appid=\(kAppKey)"
        loadEntitiesData(request_line, completion)
        
    }
    func loadWeatherData(_ coords: CoordEntity, _ completion: @escaping ResultWeatherEntity){
        var request_line = kSourceWeatherNetworkData + "?lat=\(coords.lat)&lon=\(coords.lon)&appid=\(kAppKey)"
        request_line += "&units=\(kDefaultMeasureUnitType)&lang=\(kDefaultLanguage)"
        loadEntitiesData(request_line, completion)
    }
    
    func loadWeatherIcon(_ name: String, _ completion: @escaping ResultImageEntity){
        let request_line = kSourceWeatherIconNetworkData + name + ".png"
        loadImageIcon(request_line, completion)
    }
    
    func resetAll(){
        URLSession.shared.invalidateAndCancel()
        URLCache.shared.removeAllCachedResponses()
    }
    
    // MARK: - Private
    
    func loadImageIcon(_ source: String, _ completion: @escaping ResultImageEntity){
        guard  let url = URL(string: source) else {
            completion(.failure(NSError()))
            return
        }
 
        URLSession.shared.downloadTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                completion(.failure(error ?? NSError()))
                return
            }
            
            do {
                let imageData = try Data(contentsOf: data)
                completion(.success(imageData))
            } catch let errorDecoding {
                completion(.failure(errorDecoding))
            }
          
        }.resume()
    }
    
    private func loadEntitiesData<T: Decodable>(_ source: String, _ completion: @escaping (Result<T, Error>) -> Void) {
       guard  let url = URL(string: source) else {
           completion(.failure(NSError()))
           return
       }
    
        URLSession.shared.dataTask(with: url) { data, response, error in
           guard let data = data, error == nil else {
               completion(.failure(error ?? NSError()))
               return
           }
 
           do {
               let decodedResponse = try JSONDecoder().decode(T.self, from: data)
               completion(.success(decodedResponse))
           } catch let errorDecoding {
               completion(.failure(errorDecoding))
           }
          
       }.resume()
   }
     
   private func setupStart(){

   }
}

