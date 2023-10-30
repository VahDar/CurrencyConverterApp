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
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        
    }
    
    func finish() {
        
    }
    
    
}
