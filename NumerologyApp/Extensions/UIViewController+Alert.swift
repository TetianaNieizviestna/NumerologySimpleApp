//
//  UIViewController+Alert.swift
//  NumerologyApp
//
//  Created by Tetiana on 29.01.2021.
//

import UIKit

extension UIViewController {
    func showAlert(title: String, message: String, completion: (() -> Void)? = nil) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okay = UIAlertAction(title: "OK", style: .default) { (_: UIAlertAction) in
            alertVC.dismiss(animated: true, completion: completion)
        }
        
        alertVC.addAction(okay)
        self.present(alertVC, animated: true, completion: nil)
    }
}
