//
//  AppCoordinator.swift
//  CurrencyConverterApp
//
//  Created by Vakhtang on 19.10.2023.
//

import Foundation
import UIKit

protocol AppCoordinatorProrocol: Coordinator {
    var windowScene: UIWindow? { get }
}

class AppCoordinator: AppCoordinatorProrocol {
   
    var windowScene: UIWindow?
    var childCoordinator: [Coordinator] = []
    weak var parentCoordinator: Coordinator?
    var navigationController: UINavigationController
    
    init(windowScene: UIWindow?) {
        self.windowScene = windowScene
        self.navigationController = UINavigationController()
    }
    
    func start() {
        goToTabBar()
        windowScene?.makeKeyAndVisible()
    }
    
    func finish() {
        
    }
    
    private func goToTabBar() {
        let tabBarCoordinator = TabBarCoordinator(tabBarController: TabBarController())
        windowScene?.rootViewController = tabBarCoordinator.tabBarController
        tabBarCoordinator.start()
        addChildCoordinator(tabBarCoordinator)
    }
    
}
