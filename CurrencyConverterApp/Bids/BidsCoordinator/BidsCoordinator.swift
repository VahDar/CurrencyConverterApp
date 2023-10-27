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
    }
    
    func finish() {
        removeChildCoordinator(self)
        navigationController.removeFromParent()
    }
    
    private func goToBids() {
        let viewController = BidsViewController()
        viewController.viewModel = viewModel
        navigationController.tabBarItem = UITabBarItem(title: nil, image: TabBarItem.bids.imageItems, tag: 2)
        navigationController.pushViewController(viewController, animated: true)
    }
    
}
