//
//  PhotoInfoSectionView.swift
//  PhotoProject
//
//  Created by Claire on 1/19/25.
//

import UIKit

class PhotoInfoView: BaseView {
    
    let categoryLabel = UILabel()

    let hStack = {
        let stack = UIStackView()
        stack.axis = .horizontal
        return stack
    }
    
    let titleLabel = {
        let label = UILabel()
        label.font = UIFont(name: Pretendard.bold, size: 14)
        return label
    }
    
    let infoLabel = {
        let label = UILabel()
        label.font = UIFont(name: Pretendard.regular, size: 12)
        label.textAlignment = .right
        return label
    }
    
    lazy var sizeTitleLabel = titleLabel()
    lazy var viewsTitleLabel = titleLabel()
    lazy var downloadsTitleLabel = titleLabel()
    
    lazy var sizeLabel = infoLabel()
    lazy var viewsLabel = infoLabel()
    lazy var downloadsLabel = infoLabel()
    
    func configureData(size: String, views: String, downloads: String) {
        sizeLabel.text = size
        viewsLabel.text = views
        downloadsLabel.text = downloads
    }
    
    override func configureView() {
        categoryLabel.font = UIFont(name: Pretendard.bold, size: 16)
        categoryLabel.text = String(localized: "Infos")
        sizeTitleLabel.text = String(localized: "InfoSize")
        viewsTitleLabel.text = String(localized: "InfoViews")
        downloadsTitleLabel.text = String(localized: "InfoDownloads")
    }
    
    
    override func setConstraints() {
        let sizeStack = hStack()
        sizeStack.addArrangedSubview(sizeTitleLabel)
        sizeStack.addArrangedSubview(sizeLabel)
        
        let viewsStack = hStack()
        viewsStack.addArrangedSubview(viewsTitleLabel)
        viewsStack.addArrangedSubview(viewsLabel)
        
        let downloadsStack = hStack()
        downloadsStack.addArrangedSubview(downloadsTitleLabel)
        downloadsStack.addArrangedSubview(downloadsLabel)
        
        let vStack = UIStackView()
        vStack.axis = .vertical
        vStack.spacing = 12
        vStack.alignment = .fill
        vStack.distribution = .equalSpacing
        
        vStack.addArrangedSubview(sizeStack)
        vStack.addArrangedSubview(viewsStack)
        vStack.addArrangedSubview(downloadsStack)

        [vStack, categoryLabel].forEach { view in
            addSubview(view)
        }
        
        categoryLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().inset(20)
            make.width.equalTo(100)
            make.height.equalTo(28)
        }
        
        vStack.snp.makeConstraints { make in
            make.top.trailing.bottom.equalToSuperview()
            make.trailing.equalToSuperview().inset(20)
            make.leading.equalTo(categoryLabel.snp.trailing)
        }
    }
    
}
