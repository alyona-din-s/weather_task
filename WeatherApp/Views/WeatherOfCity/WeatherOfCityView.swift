//
//  WeatherOfCityView.swift
//  WeatherApp
//
//  Created by admin_user on 13/05/23.
//
 
import Foundation
import UIKit

final class WeatherOfCityView: UIView {
    
    // MARK: - Properties
    private let viewModel: ViewModelWeather
    private let titleOfCity = UILabel()
    private let textView = UITextView()
    private let iconView = UIImageView()
    private let lastUpdate = UILabel()

        
    // MARK: - Initializer
    init(viewModel: ViewModelWeather) {
        self.viewModel = viewModel
        super.init(frame: .zero)
     }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
     
 
    // MARK: - Setup
    func setupView() {
        setupIconView()
        setupTitleView()
        setupTextView()
        setupLastUpdateView()
    }
    
    func cleanView()   {
        viewModel.resetAndClean()
        titleOfCity.text = viewModel.getNameOfCity()
        textView.text = ""
        lastUpdate.text = ""
    }
    
    // MARK: - ViewModel connection
    func loadIcon(){
        viewModel.loadWeatherInfo()
    }

    func setIcon(){
        iconView.image =  viewModel.getIconUIImage()
    }

    func loadInfo(){
        viewModel.loadWeatherInfo()
    }

    func reloadData(){
        viewModel.loadWeatherImage()
        textView.text = viewModel.getWeatherInfo()
        lastUpdate.text =  viewModel.getLastUpdateDate()

    }
    
    // MARK: - Private
    private func setupIconView() {
        addSubview(iconView)
        
        iconView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            iconView.topAnchor.constraint(equalTo: topAnchor, constant: 14),
            iconView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 14),
            iconView.heightAnchor.constraint(equalToConstant: 80),
            iconView.widthAnchor.constraint(equalTo: iconView.heightAnchor),
        ])
        
        iconView.backgroundColor = .clear
        iconView.contentMode = .scaleAspectFill
        iconView.clipsToBounds = true
        iconView.layer.cornerRadius = 40
        iconView.layer.borderColor = UIColor.white.cgColor
        iconView.layer.borderWidth = 2
 
    }
 
    private func setupTitleView() {
        addSubview(titleOfCity)
        
        titleOfCity.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleOfCity.centerYAnchor.constraint(equalTo: iconView.centerYAnchor),
            titleOfCity.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 14),
            titleOfCity.heightAnchor.constraint(equalTo: iconView.heightAnchor),
            titleOfCity.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 14)
        ])
        
        titleOfCity.backgroundColor = .clear
        titleOfCity.textAlignment = .left
        titleOfCity.textColor = .black
        titleOfCity.font = UIFont.boldSystemFont(ofSize: 24.0)
        titleOfCity.text = viewModel.getNameOfCity()
        titleOfCity.numberOfLines = 0
        titleOfCity.adjustsFontSizeToFitWidth = true
    }

    private func setupTextView() {
        addSubview(textView)
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: titleOfCity.bottomAnchor, constant: 24),
            textView.leadingAnchor.constraint(equalTo: leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: trailingAnchor),
            textView.heightAnchor.constraint(greaterThanOrEqualTo: heightAnchor, multiplier: 0.6)
        ])
        
        textView.backgroundColor = UIColor.white.withAlphaComponent(0.7)
        textView.isUserInteractionEnabled = false
        textView.textAlignment = .left
        textView.font = UIFont.systemFont(ofSize: 16.0)
        
        textView.layer.cornerRadius = 8
        textView.layer.borderWidth = 2
        textView.layer.borderColor = UIColor.white.cgColor


    }
    
    private func setupLastUpdateView() {
        addSubview(lastUpdate)
        
        lastUpdate.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            lastUpdate.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 14),
            lastUpdate.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 14),
            lastUpdate.heightAnchor.constraint(equalToConstant: 24),
            lastUpdate.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -14),
        ])
        
        lastUpdate.backgroundColor = .clear
        lastUpdate.textAlignment = .left
        lastUpdate.textColor = .white
        lastUpdate.font = UIFont.boldSystemFont(ofSize: 12.0)
    }
}
  
