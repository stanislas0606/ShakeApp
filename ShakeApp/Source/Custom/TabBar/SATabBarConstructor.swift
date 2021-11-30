//
//  SATabBarConstructor.swift
//  ShakeApp
//
//  Created by Softermii-User on 30.11.2021.
//

import UIKit

protocol SATabBarConfigurable {
    
    var tabBarControllers: [UIViewController] { get }
}

final class SATabBarConstructor {
    
    // MARK: - Properties
    private let storageDataProvider: StorageDataProvider
    private let networkDataProvider: NetworkDataProvider
    
    // MARK: - Init
    init(networkDataProvider: NetworkDataProvider, storageDataProvider: StorageDataProvider) {
        self.networkDataProvider = networkDataProvider
        self.storageDataProvider = storageDataProvider
    }
    
    // MARK - Private
    private func createMainNavigationController() -> UINavigationController {
        let model = MainModel(networkDataProvider: networkDataProvider, storageDataProvider: storageDataProvider)
        let viewModel = MainViewModel(model: model)
        let viewController = MainViewController(viewModel: viewModel)
        
        viewController.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "mostViewed"), tag: 0)
        
        return UINavigationController(rootViewController: viewController)
    }
    
    private func createHistoryNavigationController() -> UINavigationController {
        let model = SettingsModel(storageDataProvider: storageDataProvider)
        let viewModel = SettingsViewModel(model: model)
        let viewController = SettingsViewController(viewModel: viewModel)
        
        viewController.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "history"), tag: 1)
        
        return UINavigationController(rootViewController: viewController)
    }
    
}

// MARK: - SATabBarConfigurable
extension SATabBarConstructor: SATabBarConfigurable {
    
    var tabBarControllers: [UIViewController] {
        return [createMainNavigationController(), createHistoryNavigationController()]
    }
}
