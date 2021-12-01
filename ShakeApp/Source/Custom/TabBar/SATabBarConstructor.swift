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
    
    // MARK: - Private
    private func createMainNavigationController() -> UINavigationController {
        let model = MainModel(networkDataProvider: networkDataProvider, storageDataProvider: storageDataProvider)
        let viewModel = MainViewModel(model: model)
        let viewController = MainViewController(viewModel: viewModel)
        let navigationController = UINavigationController(rootViewController: viewController)
        
        navigationController.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(systemName: L10n.Icon.main),
            selectedImage: nil)
        
        return navigationController
    }
    
    private func createHistoryNavigationController() -> UINavigationController {
        let model = HistoryModel()
        let viewModel = HistoryViewModel(model: model)
        let viewController = HistoryViewController(viewModel: viewModel)
        let navigationController = UINavigationController(rootViewController: viewController)
        
        navigationController.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(systemName: L10n.Icon.history),
            selectedImage: nil)
        
        return navigationController
    }
    
}

// MARK: - SATabBarConfigurable
extension SATabBarConstructor: SATabBarConfigurable {
    
    var tabBarControllers: [UIViewController] {
        return [createMainNavigationController(), createHistoryNavigationController()]
    }
}
