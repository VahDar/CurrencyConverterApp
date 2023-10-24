//
//  WalletCoordinator.swift
//  CurrencyConverterApp
//
//  Created by Vakhtang on 21.10.2023.
//

import UIKit


class WalletCoordinator: Coordinator {
    
    var viewModel: WalletViewModelProtocol
    var childCoordinator: [Coordinator] = []
    var parentCoordinator: Coordinator?
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController, viewModel: WalletViewModelProtocol) {
        self.navigationController = navigationController
        self.viewModel = viewModel
    }
    
    func start() {
        goToWallet()
        addChildCoordinator(self)
        goToSubScreen()
    }
    
    func finish() {
        removeChildCoordinator(self)
        navigationController.removeFromParent()
    }
    private func goToWallet() {
        let viewController = WalletViewController()
        viewModel.view = viewController
        viewController.viewModel = viewModel
        navigationController.tabBarItem = UITabBarItem(title: nil, image: TabBarItem.wallet.imageItems, tag: 1)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    private func goToAddCurrency() {
        let viewController = AddCurrencyViewController()
        viewController.viewModel = viewModel
        navigationController.pushViewController(viewController, animated: true)
    }
    
    private func goToSelectScreen() {
        let viewController = SelectCountryViewController()
        viewController.viewModel = viewModel
        navigationController.pushViewController(viewController, animated: true)
    }
    
    private func backToPreviousScreen() {
        navigationController.popViewController(animated: true)
    }
    
    private func goToSubScreen() {
        viewModel.onAddCurrency = { [weak self] in
            self?.goToAddCurrency()
        }
        viewModel.onSelect = { [weak self] in
            self?.goToSelectScreen()
        }
        viewModel.backAction = { [weak self] in
            self?.backToPreviousScreen()
        }
    }
    
    
    
}
