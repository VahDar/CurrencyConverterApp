//
//  SettingCoordinator.swift
//  CurrencyConverterApp
//
//  Created by Vakhtang on 30.10.2023.
//

import UIKit


class SettingCoordinator: Coordinator {
    var childCoordinator: [Coordinator] = []
    var parentCoordinator: Coordinator?
    var navigationController: UINavigationController
    var viewModel: SettingScreenViewModel
    
    init(_ navigationController: UINavigationController, viewModel: SettingScreenViewModel) {
        self.navigationController = navigationController
        self.viewModel = viewModel
    }
    
    func start() {
        
        addChildCoordinator(self)
    }
    
    func finish() {
        removeChildCoordinator(self)
        navigationController.removeFromParent()
    }
    
    func goToSettingScreen() {
        let viewController = SettingViewController()
        viewController.viewModel = viewModel
        navigationController.tabBarItem = UITabBarItem(title: nil, image: TabBarItem.setting.imageItems, tag: 3)
        navigationController.pushViewController(viewController, animated: true)
    }
    
}
