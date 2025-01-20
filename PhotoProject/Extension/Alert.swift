//
//  ErrorAlertHelper.swift
//  PhotoProject
//
//  Created by Claire on 1/18/25.
//

import UIKit

extension UIViewController {
    
    func showAlert(title: String, message: String, completionHandler: @escaping () -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .cancel){ _ in
            alert.dismiss(animated: true)
            completionHandler()
        })
        present(alert, animated: true)
    }

}
