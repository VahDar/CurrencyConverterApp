//
//  TabBarController.swift
//  CurrencyConverterApp
//
//  Created by Vakhtang on 19.10.2023.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    private func setupTabBar() {
        self.viewControllers = [UIViewController()]
        self.viewControllers = []
        tabBar.backgroundColor = .white
        tabBar.layer.borderWidth = 1
        tabBar.layer.borderColor = UIColor.tabBarUnpressed.cgColor
        tabBar.tintColor = .tabBarPressed
    }


}
