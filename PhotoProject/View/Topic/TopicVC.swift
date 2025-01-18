//
//  TopicVC.swift
//  PhotoProject
//
//  Created by Claire on 1/18/25.
//

import UIKit
import SnapKit

class TopicVC: BaseVC {
    
    private let firstCardView = HorizontalCardView()
    private let secondCardView = HorizontalCardView()
    private let thirdCardView = HorizontalCardView()
    private let stackView = UIStackView()
    private let scrollView = UIScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func configureNav() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
        navigationController?.navigationBar.topItem?.title = "OUR TOPIC"
    }
    
    override func configureView() {
        firstCardView.sectionTitle = "골든 아워"
        secondCardView.sectionTitle = "비지니스 및 업무"
        thirdCardView.sectionTitle = "건축 및 인테리어"
        
//        stackView.backgroundColor = .orange
        
        stackView.axis = .vertical
        stackView.spacing = 12
    }
    
    override func setConstraints() {
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        
        [firstCardView, secondCardView, thirdCardView].forEach { view in
            stackView.addArrangedSubview(view)
            view.snp.makeConstraints { make in
                make.height.equalTo(280)
            }
        }
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        stackView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView.contentLayoutGuide)
            make.width.equalTo(scrollView.frameLayoutGuide)
        }
    
    }
}
