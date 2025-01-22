//
//  ColorToggleButton.swift
//  PhotoProject
//
//  Created by Claire on 1/19/25.
//

import UIKit
import SnapKit

final class ColorToggleButton: BaseButton {
    
    var color = Colors.red
    var isTapped = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addTarget(self, action: #selector(onTapped), for: .touchUpInside)
    }
    
    @objc
    private func onTapped() {
        isTapped = !isTapped
    }
 
    override func configureView() {
        configuration = .colorStyle(color: color)
    }
    
    override func setConstraints() {
        snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(28)
        }
    }
}



