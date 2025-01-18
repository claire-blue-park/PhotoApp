//
//  HorizontalCardViewCVCell.swift
//  PhotoProject
//
//  Created by Claire on 1/19/25.
//

import UIKit
import Kingfisher
import SnapKit

class HorizontalCardViewCVCell: BaseCVCell {
    
    let imageView = UIImageView()
    let starBadge = StarBadgeView()
    
    func configureData(imageUrl: String, count: Int) {
        imageView.kf.setImage(with: URL(string: imageUrl))
        starBadge.count = count
    }
    
    override func configureView() {
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
    }
    
    override func setConstraints() {
        addSubview(imageView)
        addSubview(starBadge)
        
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        starBadge.snp.makeConstraints { make in
            make.leading.equalTo(imageView.snp.leading).inset(4)
            make.bottom.equalTo(imageView.snp.bottom).inset(4)
        }
    }
}
