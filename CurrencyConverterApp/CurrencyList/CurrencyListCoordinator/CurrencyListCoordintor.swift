//
//  CurrencyListCoordintor.swift
//  CurrencyConverterApp
//
//  Created by Vakhtang on 20.10.2023.
//

import Foundation
import UIKit
import SwiftUI

final class CurrencyListCoordinator: Coordinator {
    var childCoordinator: [Coordinator] = []
    var parentCoordinator: Coordinator?
    var navigationController: UINavigationController
    var viewModel: CurrencyListViewModel
    
    init(_ navigationController: UINavigationController, viewmodel: CurrencyListViewModel) {
        self.navigationController = navigationController
        self.viewModel = viewmodel
    }
    
    func start() {
        goToCurrencyList()
    }
    
    func finish() {
        removeChildCoordinator(self)
        navigationController.removeFromParent()
    }
    
    private func goToCurrencyList() {
        let viewController = UIHostingController(rootView: CurrencyView().environmentObject(viewModel))
        navigationController.tabBarItem = UITabBarItem(title: nil, image: TabBarItem.currencyList.imageItems, tag: 0)
        navigationController.pushViewController(viewController, animated: true)
    }
    
}

