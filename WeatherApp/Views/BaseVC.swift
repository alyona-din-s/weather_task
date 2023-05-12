//
//  BaseVC.swift
//  WeatherApp
//
//  Created by admin_user on 13/05/23.
//

import Foundation


class BaseVC : UIViewController{
    
    
    func showErrorAlert(_ line: String) {
        let alert = UIAlertController(title: kAlertTitle, message: line, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: kAlertButtonCancel, style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: kAlertButtonReload, style: .default){ _ in
            self.startLoadingData()
        })
        
        self.present(alert, animated: true, completion: nil)
    }
    
}
