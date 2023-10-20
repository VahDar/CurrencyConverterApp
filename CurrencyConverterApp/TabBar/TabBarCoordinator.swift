//
//  TabBarCoordinator.swift
//  CurrencyConverterApp
//
//  Created by Vakhtang on 19.10.2023.
//

import UIKit

class TabBarCoordinator: Coordinator {
    
    var childCoordinator: [Coordinator] = []
    var parentCoordinator: Coordinator?
    let tabBarController: UITabBarController
    
    init(tabBarController: UITabBarController) {
        self.tabBarController = tabBarController
    }
    
    func start() {
        
    }
    
    func finish() {
    }
}