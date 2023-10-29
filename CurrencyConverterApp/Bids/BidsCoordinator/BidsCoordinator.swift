//
//  BidsCoordinator.swift
//  CurrencyConverterApp
//
//  Created by Vakhtang on 25.10.2023.
//

import UIKit

class BidsCoordinator: Coordinator {
    var viewModel: BidViewModelProtocol
    var childCoordinator: [Coordinator] = []
    var parentCoordinator: Coordinator?
    var navigationController: UINavigationController
    
    init(_ navigationController: UINavigationController, viewModel: BidViewModelProtocol) {
        self.navigationController = navigationController
        self.viewModel = viewModel
    }
    
    func start() {
        goToBids()
        addChildCoordinator(self)
        goToSubScreen()
    }
    
    func finish() {
        removeChildCoordinator(self)
        navigationController.removeFromParent()
    }
    
    private func goToBids() {
        let viewController = BidsViewController()
        viewModel.view = viewController
        viewController.viewModel = viewModel
        navigationController.tabBarItem = UITabBarItem(title: nil, image: TabBarItem.bids.imageItems, tag: 2)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    private func goToAddScreen() {
        let viewCOntroller = AddBidViewController()
        viewCOntroller.viewModel = viewModel
        navigationController.pushViewController(viewCOntroller, animated: true)
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
        viewModel.addBidAction = { [weak self] in
            self?.goToAddScreen()
        }
        viewModel.onSelected = { [weak self] in
            self?.goToSelectScreen()
        }
        viewModel.backAction = { [weak self] in
            self?.backToPreviousScreen()
        }
    }
    
}
