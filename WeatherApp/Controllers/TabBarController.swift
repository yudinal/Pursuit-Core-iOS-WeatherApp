//
//  TabBarController.swift
//  WeatherApp
//
//  Created by Lilia Yudina on 2/4/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    private lazy var mainVC: MainViewController = {
        let viewController = MainViewController()
        viewController.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "1.circle"), tag: 0)
        return viewController
    }()
    
    private lazy var favoriteVC: FavoriteViewController = {
        let viewController = FavoriteViewController()
        viewController.tabBarItem = UITabBarItem(title: "Forecast", image: UIImage(systemName: "2.circle"), tag: 1)
        return viewController
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = [UINavigationController(rootViewController: mainVC), favoriteVC]

    }
    

}
