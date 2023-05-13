//
//  WeatherOfCityView.swift
//  WeatherApp
//
//  Created by admin_user on 12/05/23.
//
 

import Foundation
import UIKit

final class WeatherOfCityVC: BaseVC {

    private let background = UIImageView()
    private let textView = UITextView()
    private let weatherOfCityView: WeatherOfCityView


    // MARK: - Initializer
    init(viewModel: ViewModelWeather) {
        self.weatherOfCityView = WeatherOfCityView(viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
        self.title = viewModel.getNameOfCity()

        viewModel.onWeatherLoaded = self.onWeatherLoaded
        viewModel.onWeatherLoadError = self.onWeatherLoadedWithError
        
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
    
    @objc private func reLoadAllData() {
        weatherOfCityView.cleanView()
        startLoadingData()
    }

    private func onWeatherLoaded(){
        weatherOfCityView.reloadData()
    }
    
    private func onWeatherLoadedWithError(_ errorLine: String){
        showErrorAlert(errorLine)
    }
     
}


// MARK: - Setup Views
 

extension WeatherOfCityVC   {
 
    private func setupViews(){
        view.backgroundColor = .white

        setupWeatherView()
        setupLoaderView()
    }
     
    private func setupBackgroundView() {
        view.addSubview(background)
        
        background.image = UIImage(named: "bg2")
        background.contentMode = .scaleAspectFill
        background.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: view.bottomAnchor),
            background.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            background.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            background.widthAnchor.constraint(equalTo: view.widthAnchor)]
        )
        
    }
    
    private func setupWeatherView() {
        view.addSubview(weatherOfCityView)
        
        weatherOfCityView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            weatherOfCityView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            weatherOfCityView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            weatherOfCityView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            weatherOfCityView.widthAnchor.constraint(equalTo: view.widthAnchor)]
        )
        
        weatherOfCityView.setupTextView()
    }
 
}

   
