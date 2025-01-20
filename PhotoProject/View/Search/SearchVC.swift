//
//  SearchVC.swift
//  PhotoProject
//
//  Created by Claire on 1/18/25.
//

import UIKit

class SearchVC: BaseVC {
    
    private var page = 0
    private var total = 0
    private var results: [Results] = [] {
        didSet {
            imageCV.reloadData()
        }
    }
    private var oldQuery = ""
    
    private let infoLabel = UILabel()
    private let sortButton = SortToggleButton()
    private let imageCV = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    private let colorSV = ColorSV()

    override func configureNav() {
        navigationController?.navigationBar.topItem?.title = "SEARCH PHOTO"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        let searchController = UISearchController()
        searchController.searchBar.placeholder = "키워드 검색"
        searchController.searchBar.keyboardType = .asciiCapable
        navigationItem.searchController = searchController
    }
    
    override func configureView() {
        infoLabel.font = UIFont(name: Pretendard.regular, size: 16)
        infoLabel.textColor = .neutral5
        infoLabel.text = Infos.infoSearchPhoto.toString
        
        imageCV.register(VerticalImageViewCVCell.self, forCellWithReuseIdentifier: VerticalImageViewCVCell.ofIdentifier)
        imageCV.showsVerticalScrollIndicator = false
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 4
        layout.minimumInteritemSpacing = 4
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        imageCV.collectionViewLayout = layout

        sortButton.addTarget(self, action: #selector(onSortButtonToggled), for: .touchUpInside)
    }
    
    override func setConstraints() {
        connectProtocol()
        view.addSubview(imageCV)
        view.addSubview(infoLabel)
        view.addSubview(colorSV)
        view.addSubview(sortButton)
        
        infoLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        sortButton.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview()
        }
        
//        colorSV.snp.makeConstraints { make in
//            make.verticalEdges.equalTo(sortButton)
//            make.horizontalEdges.equalToSuperview()
//            make.height.equalTo(44)
//        }
        
        imageCV.snp.makeConstraints { make in
            make.top.equalTo(sortButton.snp.bottom).offset(16)
            make.bottom.horizontalEdges.equalToSuperview()
        }
    }
    
    private func connectProtocol() {
        imageCV.delegate = self
        imageCV.dataSource = self
        imageCV.prefetchDataSource = self
        navigationItem.searchController?.searchBar.delegate = self
    }
}
// MARK: - Network
extension SearchVC {
    @objc
    private func onSortButtonToggled() {
        // 버튼 상태 업데이트
        sortButton.status = sortButton.status == Sorts.byLatest ? Sorts.byRelevance : Sorts.byLatest
        sortButton.configuration?.title = sortButton.status.toString
        
        page = 1
        callNetwork()
    }
    
    private func callNetwork() {
        let query = navigationItem.searchController?.searchBar.text?.replacingOccurrences(of: " ", with: "") ?? ""
        oldQuery = query
        
        // 검색어 없음
        if query.isEmpty {
//            showAlert(title: "검색어를 입력해주세요.", message: "한 자 이상의 검색어를 입력해주세요") { self.dismiss(animated: true) }
            return
        }
        
        NetworkManager.shared.callRequestForSearch(query: query, page: page, sort: sortButton.status) { results in
            self.total = results.total
            if self.page == 1 { self.results = results.results }
            else { self.results.append(contentsOf: results.results) }
            
            // 첫 검색일 경우 최상단으로 이동
            if self.page == 1 {
                self.imageCV.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
            }
         
            self.infoLabel.text = results.total == 0 ? Infos.infoNoResult.toString : ""
        }
    }
}

// MARK: - SearchBar
extension SearchVC: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let query = navigationItem.searchController?.searchBar.text
        if query == oldQuery { return }
        page = 1
        callNetwork()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        // TODO: - 취소 버튼 눌렀을 때 기존 결과를 지워야 할까
        results.removeAll()
        imageCV.reloadData()
        infoLabel.text = Infos.infoSearchPhoto.toString
    }
}

// MARK: - Pagenation
extension SearchVC: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        print(#function, indexPaths)
        print("total: \(total)")
        let isEnd = total == results.count
        
        for item in indexPaths {
            if isEnd == false && results.count - 2 == item.row {
                print(isEnd)
                page += 1
                callNetwork()
            }
        }
    }
}

// MARK: - CollectionView
extension SearchVC: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VerticalImageViewCVCell.ofIdentifier, for: indexPath) as! VerticalImageViewCVCell
//        cell.configureData(imageUrl: "https://blog.kakaocdn.net/dn/qpghB/btq810ErYWP/Z1KWlyUgZvMyjvChQPhJW1/img.gif", count: indexPath.row)
        
        let result = results[indexPath.row]
        cell.configureData(imageUrl: result.urls.raw, count: result.likes)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        navigationController?.modalPresentationStyle = .fullScreen
        let vc = DetailVC()
        vc.result = results[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension SearchVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sectionInset: CGFloat = 0
        let cellSpacing: CGFloat = 4
        let cellsWidth = (UIScreen.main.bounds.width - sectionInset * 2 - cellSpacing) / 2
        
        return CGSize(width: cellsWidth, height: cellsWidth * 1.3)
    }
}
