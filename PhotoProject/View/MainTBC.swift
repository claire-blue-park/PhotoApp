//
//  ViewController.swift
//  PhotoProject
//
//  Created by Claire on 1/17/25.
//

import UIKit

final class MainTBC: UITabBarController {
    
    private let tabBarItems = [(title: "토픽", image: "lamp"),
                               (title: "temp", image: "video"),
                               (title: "검색", image: "search"),
                               (title: "temp", image: "heart") ]

    override func viewDidLoad() {
        super.viewDidLoad()

        configureTabBar()
        configureAppearanceTB()
        configureAppearanceNav()
    }

    private func configureTabBar() {
        let firstVC = TopicVC()
        let secondVC = RandomVC()
        let thirdVC = SearchVC()
        let fourthVC = TempFourthVC()
        let vcs = [configureNavController(for: firstVC),
                   secondVC,
                   configureNavController(for: thirdVC),
                   configureNavController(for: fourthVC) ]

        for index in vcs.indices {
            vcs[index].tabBarItem.tag = index
            setTabBar(vc: vcs[index])
        }
        setViewControllers(vcs, animated: true)
    }
    
    private func setTabBar(vc: UIViewController) {
        let index = vc.tabBarItem.tag
        vc.tabBarItem.title = tabBarItems[index].title
        vc.tabBarItem.image = UIImage(named: tabBarItems[index].image)
    }

    private func configureAppearanceTB() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemBackground
        tabBar.standardAppearance = appearance
        tabBar.backgroundColor = .systemBackground
        tabBar.tintColor = .neutral8
    }
    
    func configureNavController(for rootViewController: UIViewController) -> UIViewController {
        let navController = UINavigationController(rootViewController:  rootViewController)
        navController.navigationBar.isTranslucent = false
        navController.navigationBar.tintColor = .neutral8
        navController.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        navController.navigationBar.backgroundColor = .systemBackground
        return navController
    }
    
    private func configureAppearanceNav() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.neutral8]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.neutral8]
    }
}

extension MainTBC: UITabBarControllerDelegate {
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        print(item)
    }
}

