//
//  CitiesSearchBar.swift
//  WeatherApp
//
//  Created by admin_user on 13/05/23.
//
 
import Foundation
import UIKit

final class CitiesSearchBar: UIView {
    
    // MARK: - Properties
    private let viewModel: ViewModelCities
    private let searchBar = UISearchBar()

        
    // MARK: - Initializer
    init(viewModel: ViewModelCities) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        searchBar.delegate = self
     }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
     
    // MARK: - UI Setup
    
    func openKeyBoard(){
        searchBar.becomeFirstResponder()
    }
    func setupView() {
        
        addSubview(searchBar)
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: leadingAnchor),
            searchBar.bottomAnchor.constraint(equalTo: bottomAnchor),
            searchBar.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        searchBar.placeholder = kPlaceholderForSearchLine
    }
}

extension CitiesSearchBar: UISearchBarDelegate  {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let q = searchBar.text else { return }
        viewModel.loadCities(q)
     }
}

