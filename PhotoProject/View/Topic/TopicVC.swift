//
//  TopicVC.swift
//  PhotoProject
//
//  Created by Claire on 1/18/25.
//

import UIKit
import SnapKit

final class TopicVC: BaseVC {
    
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
            vc.setResults(result: result)
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        }
        
        firstCardView.sectionTitle = String(localized: "TopicTitle1")
        firstCardView.didSelectItem = selectAction
        secondCardView.sectionTitle = String(localized: "TopicTitle2")
        secondCardView.didSelectItem = selectAction
        thirdCardView.sectionTitle = String(localized: "TopicTitle3")
        thirdCardView.didSelectItem = selectAction

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
        
        let group = DispatchGroup()
        
        // 1. 첫 번째 토픽
        group.enter()
        NetworkManager.shared.callRequest(api: .topic(slug: TopicSlug.goldenHour, page: 1)) { (topics: [Results]) in
            self.firstCardView.topics = topics
            group.leave()
        } failureHandler: { code, message  in
            self.showAlert(title: "Error code: \(code!)", message: message) {
                self.dismiss(animated: true)
            }
        }
        
        // 2. 두 번째 토픽
        group.enter()
        NetworkManager.shared.callRequest(api: .topic(slug: TopicSlug.businessWork, page: 1)) { (topics: [Results]) in
            self.secondCardView.topics = topics
            group.leave()
        } failureHandler: { code, message  in
            self.showAlert(title: "Error code: \(code!)", message: message) {
                self.dismiss(animated: true)
            }
        }
        
        // 3. 세 번째 토픽
        group.enter()
        NetworkManager.shared.callRequest(api: .topic(slug: TopicSlug.architectureInterior, page: 1)) { (topics: [Results]) in
            self.thirdCardView.topics = topics
            group.leave()
        } failureHandler: { code, message  in
            self.showAlert(title: "Error code: \(code!)", message: message) {
                self.dismiss(animated: true)
            }
        }
        
        group.notify(queue: .main) {
            self.firstCardView.reloadData()
            self.secondCardView.reloadData()
            self.thirdCardView.reloadData()
        }

    }
}
