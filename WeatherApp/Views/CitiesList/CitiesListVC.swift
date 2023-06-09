//
//  CitiesListVC.swift
//  WeatherApp
//
//  Created by admin_user on 12/05/23.
//

import Foundation
import UIKit

final class CitiesListVC: BaseVC {

    private let searchBarView: CitiesSearchBar
    private let citiesListView: CitiesListView
 
    // MARK: - Initializer
    init(viewModel: ViewModelCities) {
        self.searchBarView = CitiesSearchBar(viewModel: viewModel)
        self.citiesListView = CitiesListView(viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
        self.title = kTitleChooseCity

        viewModel.onStartLoadingData = self.startLoadingData
        viewModel.onChoosenCity = self.onChoosenCity
        viewModel.onCitiesLoaded = self.onCitiesLoaded
        viewModel.onCitiesLoadedError = self.onCitiesLoadedWithError
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        searchBarView.openKeyBoard()
    }
    
    // MARK: - Private
    
    
    override func startLoadingData() {
        loaderView.startAnimating()
    }
     
    private func onCitiesLoaded(){
//        DispatchQueue.main.sync {
            loaderView.stopAnimating()
            citiesListView.reloadTable()
//        }
    }
    
    private func onChoosenCity(_ city : CityEntity){
        guard let nvc = navigationController as? WeatherNavigation else { return }
        nvc.openWeatherVC(city)
    }
    
    private func onCitiesLoadedWithError(_ errorLine: String){
        loaderView.stopAnimating()
        showErrorAlert(errorLine)
    }
     
}

extension CitiesListVC   {
    
 
    private func setupViews(){
        view.backgroundColor = .white

        setupBackgroundView("bg1")
        setupSearchBar()
        setupCitiesListView()
        setupLoaderView()
    }
     
    private func setupSearchBar() {
        view.addSubview(searchBarView)

        searchBarView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchBarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBarView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            searchBarView.widthAnchor.constraint(equalTo: view.widthAnchor)]
        )
        searchBarView.setupView()

     }
    
    private func setupCitiesListView() {
        view.addSubview(citiesListView)
        
        citiesListView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            citiesListView.topAnchor.constraint(equalTo: searchBarView.bottomAnchor),
            citiesListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            citiesListView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            citiesListView.widthAnchor.constraint(equalTo: view.widthAnchor)]
        )
        
        citiesListView.setupTableView()
    }

 
}

   
