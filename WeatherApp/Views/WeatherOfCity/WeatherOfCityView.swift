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
    private let textView = UITextView()
    
        
    // MARK: - Initializer
    init(viewModel: ViewModelWeather) {
        self.viewModel = viewModel
        super.init(frame: .zero)
     }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Loading Data
     
    func cleanView()   {
        
        viewModel.resetAndClean()
        textView.text = ""
 
    }
    
    // MARK: - UI Setup
    func setupTextView() {
        addSubview(textView)
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: topAnchor),
            textView.leftAnchor.constraint(equalTo: leftAnchor),
            textView.bottomAnchor.constraint(equalTo: bottomAnchor),
            textView.rightAnchor.constraint(equalTo: rightAnchor)
        ])
        
        textView.isUserInteractionEnabled = false
  
    }
    
    func loadInfo(){
        
    }

    func reloadData(){
        
    }
}
  
