//
//  AppCoordinator.swift
//  TestProject
//
//  Created by Pavan Kumar Valluru on 21.03.20.
//  Copyright © 2020 Pavan Kumar Valluru. All rights reserved.
//

import UIKit

class AppCoordinator: BaseTabBarCoordinator {

    override func start(presentationHandler: ((Presentable) -> Void)) {
        setupTabBarItems()
        presentationHandler(tabBarController)
    }

    private func setupTabBarItems() {
        let listingsNavController = UINavigationController()
        listingsNavController.tabBarItem.title = "Home"
        let listingsCoord = ListingsCoordinator(usingNavController: listingsNavController)
        listingsCoord.start { presentableVC in
            self.appendToTabBar(presentable: presentableVC)
            self.addChildCoordinator(listingsCoord)
        }

        let favoritesNavController = UINavigationController()
        favoritesNavController.tabBarItem.title = "Favorites"
        let favoritesCoord = FavoritesCoordinator(usingNavController: favoritesNavController)
        favoritesCoord.start { presentableVC in
            self.appendToTabBar(presentable: presentableVC)
            self.addChildCoordinator(favoritesCoord)
        }

        tabBarController.viewControllers = tabBarViewControllers
        tabBarController.tabBar.accessibilityIdentifier = "MainTabBar"
    }
}
