//
//  HorizontalCardView.swift
//  PhotoProject
//
//  Created by Claire on 1/18/25.
//

import UIKit
import SnapKit


class HorizontalCardView: BaseView {
    
    var sectionTitle = "제목" {
        willSet {
            titleLabel.text = newValue
        }
    }

    private let titleLabel = UILabel()
    private let imageCV = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    override func configureView() {
//        backgroundColor = .cyan
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
            make.bottom.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
        }
    }
}

extension HorizontalCardView: UICollectionViewDelegate, UICollectionViewDataSource {
    private func connectProtocol() {
        imageCV.delegate = self
        imageCV.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HorizontalCardViewCVCell.ofIdentifier, for: indexPath) as! HorizontalCardViewCVCell
        cell.configureData(imageUrl: "https://i.pinimg.com/originals/af/95/45/af95451d7547b50c4bfd985d35537e1b.gif", count: indexPath.row)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // 셀 선택시 상세 화면 이동
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
