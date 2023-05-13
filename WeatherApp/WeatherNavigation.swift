//
//  WeatherNavigation.swift
//  WeatherApp
//
//  Created by admin_user on 13/05/23.
//

import Foundation
import UIKit

final class WeatherNavigation : UINavigationController {
 
    //MARK: -  For switching to working  / testing modes
    
    private let networkManager = NetworkManagerImpl() // NetworkManagerMock()

    private func setCitiesListVC() -> CitiesListVC {
        let viewModel = ViewModelCities(networkManager: networkManager)
        let vc = CitiesListVC(viewModel: viewModel)
        return vc
    }
    private func setWeatherOfCityVC(for city: CityEntity) -> WeatherOfCityVC {
        let viewModel = ViewModelWeather(networkManager: networkManager, city: city)
        let vc = WeatherOfCityVC(viewModel: viewModel)
        return vc
    }
    
 
    //MARK: - public

    init() {
        super.init(nibName: nil, bundle: nil)
        let citiesListVC = self.setCitiesListVC()
        self.setViewControllers([citiesListVC], animated: false)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func openWeatherVC(_ city: CityEntity){
        let weatherVC = self.setWeatherOfCityVC(for: city)
        present(weatherVC, animated: true, completion: nil)
//        pushViewController(weatherVC, animated: true)
    }
    
    func goBack(){
        popViewController(animated: true)
    }
    
}

