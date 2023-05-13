//
//  CitiesListView.swift
//  WeatherApp
//
//  Created by admin_user on 12/05/23.
//
 
import Foundation
import UIKit

final class CitiesListView: UIView {
    
    // MARK: - Properties
    private let viewModel: ViewModelCities
    private let tableView = UITableView()
    
        
    // MARK: - Initializer
    init(viewModel: ViewModelCities) {
        self.viewModel = viewModel
        super.init(frame: .zero)
     }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    func reloadTable() {
        self.tableView.reloadData()
    }
 
    func cleanView()   {
        backgroundColor = .clear
        viewModel.resetAndClean()
        reloadTable()
    }
    
    // MARK: - UI Setup
    func setupTableView() {
        addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leftAnchor.constraint(equalTo: leftAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.rightAnchor.constraint(equalTo: rightAnchor)
        ])
        tableView.backgroundColor = .clear
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelection = true
        tableView.rowHeight = 64
  
    }
}
 
extension CitiesListView: UITableViewDataSource , UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfLoadedCities()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        cell.textLabel?.text =  viewModel.getCityName(indexPath.row)
        cell.selectionStyle = .none
        return cell
    }
 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
 
        viewModel.onSelectCityAt(indexPath.row)

    }
     
}
     
    

