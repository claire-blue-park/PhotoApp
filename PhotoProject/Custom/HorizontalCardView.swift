//
//  HorizontalCardView.swift
//  PhotoProject
//
//  Created by Claire on 1/18/25.
//

import UIKit
import SnapKit


final class HorizontalCardView: BaseView {
    var didSelectItem: ((Results) -> Void)?
    
    var sectionTitle = "제목" {
        willSet {
            titleLabel.text = newValue
        }
    }
    
    var topics: [Results] = []
    
//    var topics: [Results] = [] {
//        didSet {
//            imageCV.reloadData()
//        }
//    }

    private let titleLabel = UILabel()
    private let imageCV = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    func reloadData() {
        imageCV.reloadData()
    }
    
    override func configureView() {
        titleLabel.textColor = .neutral8
        titleLabel.font = UIFont(name: Pretendard.bold, size: 18)
    
        imageCV.register(HorizontalCardViewCVCell.self, forCellWithReuseIdentifier: HorizontalCardViewCVCell.ofIdentifier)
        imageCV.showsHorizontalScrollIndicator = false
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        imageCV.collectionViewLayout = layout
    }
    
    override func setConstraints() {
        connectProtocol()
        addSubview(titleLabel)
        addSubview(imageCV)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.horizontalEdges.equalToSuperview().offset(20)
            make.height.equalTo(20)
        }
        
        imageCV.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.bottom.horizontalEdges.equalToSuperview()
        }
    }
    
    private func connectProtocol() {
        imageCV.delegate = self
        imageCV.dataSource = self
    }
}

extension HorizontalCardView: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return topics.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HorizontalCardViewCVCell.ofIdentifier, for: indexPath) as! HorizontalCardViewCVCell
        let topic = topics[indexPath.row]
        cell.configureData(imageUrl: topic.urls.thumb, count: topic.likes)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectItem?(topics[indexPath.row])
    }
}

extension HorizontalCardView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sectionInset: CGFloat = 20
        let cellSpacing: CGFloat = 12
        let cellsWidth = (UIScreen.main.bounds.width - sectionInset * 2 - cellSpacing) / 1.8
        
        return CGSize(width: cellsWidth, height: cellsWidth * 1.3)
    }
}
