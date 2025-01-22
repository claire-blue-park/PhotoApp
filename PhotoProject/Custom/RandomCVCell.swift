//
//  RandomCVCell.swift
//  PhotoProject
//
//  Created by Claire on 1/22/25.
//

import UIKit
import Kingfisher
import SnapKit

final class RandomCVCell: BaseCVCell {
    
    private let imageView = UIImageView()
    private let profileView = ProfileView()
    
    func configureData(result: Results) {
        imageView.kf.setImage(with: URL(string: result.urls.small))
        profileView.configureData(imageUrl: result.user.profileImage.medium, name: result.user.name, date: result.createdAt)
    }

    override func configureView() {
        imageView.contentMode = .scaleAspectFill
                            
        profileView.setTextColor(isWhite: true)
    }
    
    override func setConstraints() {
        contentView.addSubview(imageView)
        contentView.addSubview(profileView)
        
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        profileView.snp.makeConstraints { make in
            make.bottom.equalTo(imageView.snp.bottom).inset(100)
            make.horizontalEdges.equalTo(imageView.snp.horizontalEdges)
        }
    }
}
