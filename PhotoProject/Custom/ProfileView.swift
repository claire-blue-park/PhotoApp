//
//  ProfileView.swift
//  PhotoProject
//
//  Created by Claire on 1/19/25.
//

import UIKit
import Kingfisher
import SnapKit

class ProfileView: BaseView {
    
    private let profileImageView = UIImageView()
    private let vStack = UIStackView()
    private let nameLabel = UILabel()
    private let dateLabel = UILabel()
    
    func configureData(imageUrl: String, name: String, date: String) {
        profileImageView.kf.setImage(with: URL(string: imageUrl))
        nameLabel.text = name
        dateLabel.text = date
    }
    
    override func configureView() {
        profileImageView.layer.cornerRadius = 22
        profileImageView.contentMode = .scaleAspectFit
        profileImageView.clipsToBounds = true
        
        vStack.axis = .vertical
        vStack.spacing = 4
        
        nameLabel.font = UIFont(name: Pretendard.regular, size: 16)
        nameLabel.textColor = .neutral8
        
        dateLabel.font = UIFont(name: Pretendard.bold, size: 12)
        dateLabel.textColor = .neutral8
    }
    
    override func setConstraints() {
        [nameLabel, dateLabel].forEach { view in
            vStack.addArrangedSubview(view)
        }
        
        [profileImageView, vStack].forEach { view in
            addSubview(view)
        }
        
        profileImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.verticalEdges.equalToSuperview()
            make.size.equalTo(44)
        }
        
        vStack.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.top)
            make.bottom.equalTo(profileImageView.snp.bottom)
            make.leading.equalTo(profileImageView.snp.trailing).offset(12)
            make.trailing.equalToSuperview()
            make.height.equalTo(44)
        }
    }
    
}
