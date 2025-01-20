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
    private let scrollView = UIScrollView()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        callNetwork()
    }
    
    override func configureNav() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
        navigationController?.navigationBar.topItem?.title = "OUR TOPIC"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
    }
    
    override func configureView() {
        let selectAction = { result in
            let vc = DetailVC()
            vc.result = result
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        firstCardView.sectionTitle = String(localized: "TopicTitle1")
        firstCardView.didSelectItem = selectAction
        secondCardView.sectionTitle = String(localized: "TopicTitle2")
        secondCardView.didSelectItem = selectAction
        thirdCardView.sectionTitle = String(localized: "TopicTitle3")
        thirdCardView.didSelectItem = selectAction
        
//        container.backgroundColor = .orange
        scrollView.showsVerticalScrollIndicator = false
    }
    
    override func setConstraints() {
        let container = UIStackView()
        container.axis = .vertical
        container.spacing = 12
        
        view.addSubview(scrollView)
        scrollView.addSubview(container)
        
        [firstCardView, secondCardView, thirdCardView].forEach { view in
            container.addArrangedSubview(view)
            view.snp.makeConstraints { make in
                make.height.equalTo(280)
            }
        }
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        container.snp.makeConstraints { make in
            make.edges.equalTo(scrollView.contentLayoutGuide)
            make.width.equalTo(scrollView.frameLayoutGuide)
        }
    }
    
    private func callNetwork() {
        NetworkManager.shared.callRequestForTopic(topicSlug: TopicSlug.goldenHour, page: 1) { topics in
            self.firstCardView.topics = topics
        }
        
        NetworkManager.shared.callRequestForTopic(topicSlug: TopicSlug.businessWork, page: 1) { topics in
            self.secondCardView.topics = topics
        }
        
        NetworkManager.shared.callRequestForTopic(topicSlug: TopicSlug.architectureInterior, page: 1) { topics in
            self.thirdCardView.topics = topics
        }
    }
}
