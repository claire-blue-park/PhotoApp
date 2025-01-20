//
//  DetailVC.swift
//  PhotoProject
//
//  Created by Claire on 1/18/25.
//

import UIKit
import Kingfisher
import SnapKit

class DetailVC: BaseVC {
    
    var result: Results? = nil
    
    private let scrollView = UIScrollView()
    private let profileView = ProfileView()
    private let imageView = UIImageView()
    private let infoView = PhotoInfoView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureData()

    }
    
    override func configureNav() {
        navigationItem.largeTitleDisplayMode = .never
    }
    
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
        
        self.imageView.kf.setImage(with: URL(string: result.urls.raw))
        
        NetworkManager.shared.callRequestForDetail(imageId: result.id) { statistics in
            self.infoView.configureData(size: "\(result.width) X \(result.height)",
                                        views: statistics.views.total.formatted(),
                                        downloads: statistics.downloads.total.formatted())
        }
    }
    
    override func configureView() {
//        scrollView.backgroundColor = .cyan
//        infoView.backgroundColor = .green
        view.backgroundColor = .systemBackground
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        scrollView.showsVerticalScrollIndicator = false
    }
    
    override func setConstraints() {
        let container = UIStackView()
        container.axis = .vertical
        container.spacing = 12
        
        view.addSubview(scrollView)
        scrollView.addSubview(container)
        
        [profileView, imageView, infoView].forEach { view in
            container.addArrangedSubview(view)
        }

        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        container.snp.makeConstraints { make in
            make.edges.equalTo(scrollView.contentLayoutGuide)
            make.width.equalTo(scrollView.frameLayoutGuide)
        }
        
        imageView.snp.makeConstraints { make in
            make.height.equalTo(300) // TODO: - 이미지 높이 수정
        }
    }
}
