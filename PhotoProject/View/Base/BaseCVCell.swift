//
//  BaseCVCell.swift
//  PhotoProject
//
//  Created by Claire on 1/19/25.
//

import UIKit

class BaseCVCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        setConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() {  }
    func setConstraints() {  }
}
