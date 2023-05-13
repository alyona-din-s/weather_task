//
//  CitiesListVC.swift
//  WeatherApp
//
//  Created by admin_user on 12/05/23.
//

import Foundation
import UIKit

final class CitiesListVC: BaseVC {

    private let searchBar = UISearchBar()
    private let citiesListView: CitiesListView
 
    // MARK: - Initializer
    init(viewModel: ViewModelCities) {
        self.citiesListView = CitiesListView(viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
        self.title = kTitleChooseCity

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
    
    // MARK: - Private
    
    override func startLoadingData() {
        loaderView.startAnimating()
        citiesListView.loadFirstDataForTableWith()
    }
    
    @objc private func reLoadAllData() {
        citiesListView.cleanView()
        startLoadingData()
    }

    private func onCitiesLoaded(){
        loaderView.stopAnimating()
        citiesListView.reloadTable()
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


// MARK: - Setup Views

extension CitiesListVC: UISearchBarDelegate  {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
       
    }
}


extension CitiesListVC   {
    
 
    private func setupViews(){
        view.backgroundColor = .white

        setupSearchBar()
        setupCitiesListView()
        setupLoaderView()
    }
    
    private func setupSearchBar() {
        view.addSubview(searchBar)

        searchBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            searchBar.widthAnchor.constraint(equalTo: view.widthAnchor)]
        )
        searchBar.delegate = self
        searchBar.placeholder = kPlaceholderForSearchLine
     }
    
    private func setupCitiesListView() {
        view.addSubview(citiesListView)
        
        citiesListView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            citiesListView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            citiesListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            citiesListView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            citiesListView.widthAnchor.constraint(equalTo: view.widthAnchor)]
        )
        
        citiesListView.setupTableView()
    }

 
}

   
