//
//  BaseVC.swift
//  PhotoProject
//
//  Created by Claire on 1/18/25.
//

import UIKit

class BaseVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNav()
        configureView()
        setConstraints()
    }
    
    func configureNav() {  }
    func configureView() {
        view.backgroundColor = .systemBackground
    }
    func setConstraints() {  }

}
