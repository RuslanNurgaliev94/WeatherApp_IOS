//
//  addCity.swift
//  WeatherTestTask
//
//  Created by Руслан Нургалиев on 30.08.2022.
//

import UIKit

extension UIViewController {
    
    func alertPlusCity(name: String, placeholder: String, completionHandler: @escaping (String) -> ()) {
        
        let alertController = UIAlertController(title: name, message: nil, preferredStyle: .alert)
        let alertOk = UIAlertAction(title: "Ok", style: .default) { action in
            let tftext = alertController.textFields?.first
            guard let text = tftext?.text else { return }
            completionHandler(text)
        }
        alertController.addTextField { tf in
            tf.placeholder = placeholder
        }
        let alertCancel = UIAlertAction(title: "Отмена", style: .default) { _ in
        }
        alertController.addAction(alertOk)
        alertController.addAction(alertCancel)
        present(alertController, animated: true)
    }
}
