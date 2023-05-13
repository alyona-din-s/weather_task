//
//  ViewModel.swift
//  WeatherApp
//
//  Created by admin_user on 12/05/23.
//

import Foundation
import UIKit

typealias onInfoCompletion = () -> Void
typealias onErrorCompletion = (_ errorLine: String) -> Void
 
final class ViewModelCities {
 
    // MARK: - Properties
    private let networkManager: NetworkManager
    private var citiesArray: [CityEntity] = []
 
    
    // MARK: -
    var onCitiesLoaded: onInfoCompletion?
    var onCitiesLoadedError: onErrorCompletion?
    var onChoosenCity : ((CityEntity) -> Void)?
          
    
    // MARK: - Initializer
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
        self.citiesArray = []
      }
    
    // MARK: - Public
    func getNumberOfLoadedCities() -> Int{
        return citiesArray.count
    }
    
    func getCityName(_ ind: Int) -> String? {
        guard ind < citiesArray.count else{ return nil }
        return citiesArray[ind].name
    }

    
    func onSelectCityAt(_ ind: Int) {
        guard ind < citiesArray.count else { return }
        let city = citiesArray[ind]
        onChoosenCity?(city)
    }
    
    func loadCities(_ query_line: String)   {
        guard !query_line.isEmpty else {
//            onCitiesLoadedError?(WeatherError.emptyCityQueryError.localizedDescription)
            return
        }
        
        let handler : ResultCitiesEntity = { result in
            DispatchQueue.main.async{ [weak self] in
                switch result {
                case .success(let cities) :
                    self?.citiesArray = cities
                    self?.onCitiesLoaded?()
                case .failure(let error_line) :
                    self?.onCitiesLoadedError?(error_line.localizedDescription)
                }
            }
        }
        
        networkManager.loadCitiesData(query_line, handler)
    }
    
    func resetAndClean(){
        citiesArray.removeAll()
        networkManager.resetAll()
    }
     
    
}
    




