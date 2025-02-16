//
//  RandomVC.swift
//  PhotoProject
//
//  Created by Claire on 1/18/25.
//

import UIKit
import Kingfisher
import SnapKit

final class RandomVC: BaseViewController {
    
    private let pagingCV = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    private var randoms: [Results] = [] {
        didSet {
            pagingCV.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        connectProtocol()
        callNetwork()
    }
    
    private func callNetwork() {
        NetworkManager.shared.callRequest(api: .random(count: 10)) { (randoms: [Results]) in
            self.randoms = randoms
        } failureHandler: { code, message  in
            self.showAlert(title: "Error code: \(code!)", message: message) {
                self.dismiss(animated: true)
            }
        }
    }
    
    override func configureView() {
        pagingCV.contentInsetAdjustmentBehavior = .never
        pagingCV.showsVerticalScrollIndicator = false
        pagingCV.isPagingEnabled = true
        pagingCV.bouncesVertically = false
        pagingCV.register(RandomCVCell.self, forCellWithReuseIdentifier: RandomCVCell.ofIdentifier)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        pagingCV.collectionViewLayout = layout
    }
    
    override func setConstraints() {
        view.addSubview(pagingCV)
        
        pagingCV.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func connectProtocol() {
        pagingCV.delegate = self
        pagingCV.dataSource = self
    }
    
}

extension RandomVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return randoms.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = pagingCV.dequeueReusableCell(withReuseIdentifier: RandomCVCell.ofIdentifier, for: indexPath) as! RandomCVCell
        cell.configureData(result: randoms[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.setResults(result: randoms[indexPath.row])
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
}

extension RandomVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let cellsWidth = UIScreen.main.bounds.width
        let cellsHeight = UIScreen.main.bounds.height
        
        // TODO: - 탭첫 화면 safe 기준으로 걸려버림 ㅠㅠ
        
        return CGSize(width: cellsWidth, height: cellsHeight)
    }
}
