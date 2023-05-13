//
//  WeatherOfCityView.swift
//  WeatherApp
//
//  Created by admin_user on 12/05/23.
//
 

import Foundation
import UIKit

final class WeatherOfCityVC: BaseVC {

    private let textView = UITextView()
    private let weatherOfCityView: WeatherOfCityView


    // MARK: - Initializer
    init(viewModel: ViewModelWeather) {
        self.weatherOfCityView = WeatherOfCityView(viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
 
        viewModel.onWeatherLoaded = self.onWeatherLoaded
        viewModel.onWeatherLoadError = self.onWeatherLoadedWithError
        viewModel.onIconDataLoaded = self.onIconLoaded
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        startLoadingData()
    }
    
    // MARK: - Private
    
    override func startLoadingData() {
        loaderView.startAnimating()
        weatherOfCityView.loadInfo()
    }
     

    private func onIconLoaded(){
        weatherOfCityView.setIcon()
    }
    
    private func onWeatherLoaded(){
        loaderView.stopAnimating()
        weatherOfCityView.reloadData()
    }
    
    private func onWeatherLoadedWithError(_ errorLine: String){
        loaderView.stopAnimating()
        showErrorAlert(errorLine)
    }
     
}


// MARK: - Setup Views
 

extension WeatherOfCityVC   {
 
    private func setupViews(){
        view.backgroundColor = .white

        setupBackgroundView("bg2")
        setupWeatherView()
        setupLoaderView()
    }

    private func setupWeatherView() {
        view.addSubview(weatherOfCityView)
        
        weatherOfCityView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            weatherOfCityView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            weatherOfCityView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            weatherOfCityView.heightAnchor.constraint(equalTo: view.heightAnchor ,multiplier: 0.8),
            weatherOfCityView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9)]
        )
        
        weatherOfCityView.setupView()
    }
 
}

   
