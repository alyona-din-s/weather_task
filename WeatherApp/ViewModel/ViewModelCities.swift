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
    private let localStorageManager: LocalStorage
    
    private var citiesArray: [CityEntity] = []
 
    
    // MARK: -
    var onStartLoadingData : onInfoCompletion?
    var onCitiesLoaded: onInfoCompletion?
    var onCitiesLoadedError: onErrorCompletion?
    var onChoosenCity : ((CityEntity) -> Void)?
        
    
    // MARK: - Initializer
    init(networkManager: NetworkManager, localStorageManager: LocalStorage) {
        self.networkManager = networkManager
        self.localStorageManager = localStorageManager
        
        self.citiesArray = []
      }
    
    // MARK: - Public
    func getNumberOfLoadedCities() -> Int{
        return citiesArray.count
    }
    
    func getCityName(_ ind: Int) -> String? {
        guard ind < citiesArray.count else{ return nil }
        var name = citiesArray[ind].name.capitalized
        if let country = citiesArray[ind].country  {
            name += " (" + country.capitalized + ")"
        }
        return name
    }

    
    func onSelectCityAt(_ ind: Int) {
        guard ind < citiesArray.count else { return }
        let city = citiesArray[ind]
        onChoosenCity?(city)
    }
    
    func loadCities(_ query_line: String)   {
        guard !query_line.isEmpty else {return }
         
        onStartLoadingData?()
        
        let handler : ResultCitiesEntity = { [weak self]  result in
            DispatchQueue.main.async{ [weak self] in
                switch result {
                case .success(let cities) :
                    self?.citiesArray = cities
                    self?.localStorageManager.saveCitySearch(query_line, cities)
                    self?.onCitiesLoaded?()
                case .failure(let error as NSError) :

                    if let cities = self?.localStorageManager.getCities(query_line){
                        self?.citiesArray = cities
                        self?.onCitiesLoaded?()
                        return
                    }

                    if ![NSURLErrorUnknown, 0].contains(error.code) {
                        self?.onCitiesLoadedError?(error.localizedDescription)
                    } else {
                        //TODO: - fix local coding error
                        self?.onCitiesLoadedError?(kErrorInternal)
                    }

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
    




