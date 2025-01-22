//
//  DetailVC.swift
//  PhotoProject
//
//  Created by Claire on 1/18/25.
//

import UIKit
import Kingfisher
import SnapKit

final class DetailVC: BaseVC {
    
    private var result: Results? = nil
    
    private let scrollView = UIScrollView()
    private let profileView = ProfileView()
    private let imageView = UIImageView()
    private let infoView = PhotoInfoView()
    
    private let backButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureData()

    }
    
    func setResults(result: Results) {
        self.result = result
    }
    
//    override func configureNav() {
//        navigationController?.isNavigationBarHidden = false
//        navigationItem.largeTitleDisplayMode = .never
//    }
    
    func configureData() {
        guard let result else {
            showAlert(title: "사진을 찾을 수 없습니다.", message: "사진 정보가 없습니다.") {
                self.dismiss(animated: true)
                self.navigationController?.popViewController(animated: true)
            }
            return
        }
        
        var createdAt = result.createdAt
        DateFormatterManager.shared.getDateFormat(createdAt) { date in
            createdAt = date
        }
        self.profileView.configureData(imageUrl: result.user.profileImage.medium, name: result.user.name, date: "\(createdAt) 게시")
        
        self.imageView.kf.setImage(with: URL(string: result.urls.small))
        
        NetworkManager.shared.callRequest(api: .detail(id: result.id)) { (statistics: Statistics) in
            self.infoView.configureData(size: "\(result.width) X \(result.height)",
                                        views: statistics.views.total.formatted(),
                                        downloads: statistics.downloads.total.formatted())
        } failureHandler: { code, message  in
            self.showAlert(title: "Error code: \(code!)", message: message) {
                self.dismiss(animated: true)
            }
        }
    }
    
    @objc
    private func onBackTapped() {
        dismiss(animated: false)
    }
    
    override func configureView() {
        view.backgroundColor = .systemBackground
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        backButton.configuration = .backButtonStyle()
        backButton.addTarget(self, action: #selector(onBackTapped), for: .touchUpInside)
        
        scrollView.showsVerticalScrollIndicator = false
    }
    
    override func setConstraints() {
        let container = UIStackView()
        container.axis = .vertical
        container.spacing = 12
        
        view.addSubview(backButton)
        view.addSubview(scrollView)
        scrollView.addSubview(container)
        
        [profileView, imageView, infoView].forEach { view in
            container.addArrangedSubview(view)
        }
        
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            make.size.equalTo(44)
        }

        scrollView.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom)
            make.bottom.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
        
        container.snp.makeConstraints { make in
            make.edges.equalTo(scrollView.contentLayoutGuide)
            make.width.equalTo(scrollView.frameLayoutGuide)
        }
        
        imageView.snp.makeConstraints { make in
            make.height.equalTo(300) // TODO: - 이미지 높이 유동적으로 수정
        }
    }
}
