//
//  StarBadgeView.swift
//  PhotoProject
//
//  Created by Claire on 1/19/25.
//

import UIKit
import SnapKit

class StarBadgeView: BaseView {

    private let iconImageView = UIImageView()
    private let countLabel =  UILabel()
    
    func setCount(_ count: Int) {
        countLabel.text = count.formatted()
    }
    
    
    override func configureView() {
        backgroundColor = .neutral6
        layer.cornerRadius = 12
        clipsToBounds = true
        
        iconImageView.image = UIImage(systemName: "star.fill")
        iconImageView.tintColor = .systemYellow
        iconImageView.contentMode = .scaleAspectFit
        
        countLabel.textColor = .neutral0
        countLabel.font = UIFont(name: Pretendard.regular, size: 10)
    }
    
    override func setConstraints() {
        addSubview(iconImageView)
        addSubview(countLabel)
        
        snp.makeConstraints { make in
            make.height.equalTo(24)
        }
        
        iconImageView.snp.makeConstraints { make in
            make.leading.verticalEdges.equalToSuperview().inset(2)
            make.size.equalTo(20)
        }
        
        countLabel.snp.makeConstraints { make in
            make.leading.equalTo(iconImageView.snp.trailing).offset(4)
            make.trailing.verticalEdges.equalToSuperview().inset(8)
        }
    }
    
}
