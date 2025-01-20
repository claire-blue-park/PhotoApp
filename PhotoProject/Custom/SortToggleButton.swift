//
//  SortToggleButton.swift
//  PhotoProject
//
//  Created by Claire on 1/19/25.
//

import UIKit
import SnapKit

class SortToggleButton: BaseButton {
    
    var status = Sorts.byLatest
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
 
    override func configureView() {
        configuration = .sortStyle(status)
    }
    
    override func setConstraints() {
        snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(28)
        }
    }
}



