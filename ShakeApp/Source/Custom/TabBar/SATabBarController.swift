//
//  SATabBarController.swift
//  ShakeApp
//
//  Created by Softermii-User on 30.11.2021.
//

import UIKit

final class SATabBarController: UITabBarController {
    
    // MARK: - Properties
    var tabBarConstructor: SATabBarConstructor
    
    // MARK: - Init
    init(constructor: SATabBarConstructor) {
        self.tabBarConstructor = constructor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.tintColor = Asset.Colors.grayColor.color
        viewControllers = tabBarConstructor.tabBarControllers
    }
}
