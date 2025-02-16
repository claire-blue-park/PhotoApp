//
//  BaseViewController.swift
//  PhotoProject
//
//  Created by Claire on 1/18/25.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNav()
        configureView()
        setConstraints()
    }
    
    func configureNav() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
    }
    func configureView() {
        view.backgroundColor = .systemBackground
    }
    func setConstraints() {  }

}
