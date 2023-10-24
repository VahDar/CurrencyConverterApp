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
        currencyList()
        walletScreen()
    }
    
    func finish() {
    }
    
    private func currencyList() {
        let viewModel = CurrencyListViewModel()
        let coordinator = CurrencyListCoordinator(UINavigationController(), viewmodel: viewModel)
        tabBarController.viewControllers?.append(coordinator.navigationController)
        addChildCoordinator(coordinator)
        coordinator.start()
    }
    
    private func walletScreen() {
        let realmService = RealmService()
        let networkService = NetworkingService()
        let viewModel = WalletViewModel(networkService: networkService, realmService: realmService)
        let coordinator = WalletCoordinator(navigationController: UINavigationController(), viewModel: viewModel)
        tabBarController.viewControllers?.append(coordinator.navigationController)
        addChildCoordinator(coordinator)
        coordinator.start()
    }
}
