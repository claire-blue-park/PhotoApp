//
//  DetailViewController.swift
//  PhotoProject
//
//  Created by Claire on 1/18/25.
//

import UIKit
import Kingfisher
import SnapKit

final class DetailViewController: BaseViewController {
    
    private let viewModel = DetailViewModel()
    
    private let scrollView = UIScrollView()
    private let profileView = ProfileView()
    private let imageView = UIImageView()
    private let infoView = PhotoInfoView()
    
    private let backButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindData()
    }
    
    // 외부에서 값 받아옴
    func setResults(result: Results) {
        viewModel.input.result.value = result
    }

    
    private func bindData() {
        viewModel.output.result.bind { [weak self] result in
            guard let self else { return }
            if let result {

                profileView.configureData(imageUrl: result.user.profileImage.medium, name: result.user.name, date: "\(viewModel.output.postDateInfo)")

                imageView.kf.setImage(with: URL(string: result.urls.small))
            }
        
            
        }
        
        viewModel.output.imageInfo.bind { [weak self] info in
            guard let self else { return }
            if let info {
                infoView.configureData(size: info.size, views: info.views, downloads: info.downloads)
            } else {
                showAlert(title: "사진을 찾을 수 없습니다.", message: viewModel.output.errorMessage) {
                    self.dismiss(animated: true)
                    self.navigationController?.popViewController(animated: true)
                }
                return
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
