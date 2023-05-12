//
//  WeatherOfCityView.swift
//  WeatherApp
//
//  Created by admin_user on 12/05/23.
//
 

import Foundation
import UIKit

final class WeatherOfCityVC: BaseVC {

    private let loaderView = UIActivityIndicatorView()
    private let textView = UITextView() 
    private let weatherOfCityView: WeatherOfCityView


    // MARK: - Initializer
    init(viewModel: ViewModelWeather) {
        self.weatherOfCityView = WeatherOfCityView(viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
        
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
    
    private func startLoadingData() {
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

extension CitiesListVC: UISearchBarDelegate  {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
       
         citiesListView.reloadTable()
    }
}


extension CitiesListVC   {
    
    func showErrorAlert(_ line: String) {
        let alert = UIAlertController(title: kAlertTitle, message: line, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: kAlertButtonCancel, style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: kAlertButtonReload, style: .default){ _ in
            self.startLoadingData()
        })
        
        self.present(alert, animated: true, completion: nil)
    }
 
    private func setupViews(){
        view.backgroundColor = .white

        setupWeatherView()
        setupLoaderView()
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

    private func setupLoaderView() {
        view.addSubview(loaderView)

        loaderView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loaderView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loaderView.centerYAnchor.constraint(equalTo: view.centerYAnchor)])
        
        loaderView.style = .large
        loaderView.hidesWhenStopped = true
    }
  
 
}

   
