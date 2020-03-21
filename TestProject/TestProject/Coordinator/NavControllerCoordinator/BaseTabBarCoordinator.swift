//
//  BaseTabBarCoordinator.swift
//  TestProject
//
//  Created by Pavan Kumar Valluru on 21.03.20.
//  Copyright © 2020 Pavan Kumar Valluru. All rights reserved.
//

import UIKit

class BaseTabBarCoordinator: Coordinator {

    // MARK: - Vars & Lets
    var childCoordinators = [Coordinator]()
    var tabBarController = UITabBarController()
    var tabBarViewControllers = [UIViewController]()

    func start(presentationHandler: ((Presentable) -> Void)) {
        fatalError("Children should override this method")
    }

    func appendToTabBar(presentable: Presentable) {
        if let vc = presentable as? UIViewController {
            tabBarViewControllers.append(vc)
        } else {
            fatalError("Expected a sub class of View Controller")
        }
    }
}
