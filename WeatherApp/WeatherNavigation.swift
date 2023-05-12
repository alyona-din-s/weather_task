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
        return CitiesListVC(viewModel: viewModel)
    }
    private func setWeatherOfCityVC(_ coords: CoordEntity) -> WeatherOfCityVC {
        let viewModel = ViewModelWeather(networkManager: networkManager, coords: coords)
        return WeatherOfCityVC(viewModel: viewModel)
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
    
    
    func openWeatherVC(_ coords: CoordEntity){
        let weatherVC = self.setWeatherOfCityVC(coords)
        pushViewController(weatherVC, animated: true)
    }
    
    func goBack(){
        popViewController(animated: true)
    }
    
}

