//
//  BaseVC.swift
//  WeatherApp
//
//  Created by admin_user on 13/05/23.
//

import Foundation
import UIKit


class BaseVC : UIViewController {
    
    
    let loaderView = UIActivityIndicatorView()

    func showErrorAlert(_ line: String) {
        let alert = UIAlertController(title: kAlertTitle, message: line, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: kAlertButtonCancel, style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: kAlertButtonReload, style: .default){ _ in
            self.startLoadingData()
        })
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        startLoadingData()

    }
    
    func startLoadingData(){
        
    }
    
    
    func setupLoaderView() {
        view.addSubview(loaderView)

        loaderView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loaderView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loaderView.centerYAnchor.constraint(equalTo: view.centerYAnchor)])
        
        loaderView.style = .large
        loaderView.hidesWhenStopped = true
    }
  
    
}
