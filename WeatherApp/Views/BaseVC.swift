//
//  BaseVC.swift
//  WeatherApp
//
//  Created by admin_user on 13/05/23.
//

import Foundation
import UIKit


class BaseVC : UIViewController {
    
    let background = UIImageView()
    let loaderView = UIActivityIndicatorView()

    func showErrorAlert(_ line: String) {
        loaderView.stopAnimating()
        let alert = UIAlertController(title: kAlertTitle, message: line, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: kAlertButtonCancel, style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: kAlertButtonReload, style: .default){ _ in
            self.startLoadingData()
        })
        
        self.present(alert, animated: true, completion: nil)
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
    
    
    func setupBackgroundView(_ name: String) {
       view.addSubview(background)
       
       background.image = UIImage(named: name)
//       background.layer.opacity = 0.6
       background.contentMode = .scaleAspectFill
       background.translatesAutoresizingMaskIntoConstraints = false
       NSLayoutConstraint.activate([
           background.centerYAnchor.constraint(equalTo: view.centerYAnchor),
           background.centerXAnchor.constraint(equalTo: view.centerXAnchor),
           background.heightAnchor.constraint(equalTo: view.heightAnchor),
           background.widthAnchor.constraint(equalTo: view.widthAnchor)]
       )
       
   }
   
    
}
