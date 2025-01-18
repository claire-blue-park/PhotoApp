//
//  ViewController.swift
//  PhotoProject
//
//  Created by Claire on 1/17/25.
//

import UIKit

class MainVC: UITabBarController {
    
    
    private let tabBarItems = [(title: "토픽", image: "lamp"),
                               (title: "temp", image: "video"),
                               (title: "검색", image: "search"),
                               (title: "temp", image: "heart") ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        checkFontName()
        
        configureTabBar()
        configureAppearanceTB()
        configureAppearanceNav()
    }
    
    private func checkFontName() {
        for family in UIFont.familyNames {
            print(family)
            for names in UIFont.fontNames(forFamilyName: family) {
                print( "== \(names)")
            }
        }
        /*
         Pretendard
         == Pretendard-Regular
         == Pretendard-Thin
         == Pretendard-ExtraLight
         == Pretendard-Light
         == Pretendard-Medium
         == Pretendard-SemiBold
         == Pretendard-Bold
         == Pretendard-ExtraBold
         == Pretendard-Black
         */
    }
    
    private func configureTabBar() {
        let firstVC = TopicVC()
        let secondVC = TempSecondVC()
        let thirdVC = SearchVC()
        let fourthVC = TempFourthVC()
        let vcs = [configureNavController(for: firstVC),
                   configureNavController(for: secondVC),
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
        appearance.backgroundColor = .white
        tabBar.standardAppearance = appearance
        tabBar.backgroundColor = .white
        tabBar.tintColor = .black
    }
    
    func configureNavController(for rootViewController: UIViewController) -> UIViewController {
        let navController = UINavigationController(rootViewController:  rootViewController)
        navController.navigationBar.isTranslucent = false
        navController.navigationBar.backgroundColor = .white
        navController.interactivePopGestureRecognizer?.delegate = nil // 스와이프 제스처 enable true
        return navController
    }
    
    private func configureAppearanceNav() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
    }
}

extension MainVC: UITabBarControllerDelegate {
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        print(item)
    }
}

