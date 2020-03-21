//
//  FavoritesCoordinator.swift
//  TestProject
//
//  Created by Pavan Kumar Valluru on 21.03.20.
//  Copyright © 2020 Pavan Kumar Valluru. All rights reserved.
//

import UIKit

class FavoritesCoordinator: BaseRouterCoordinator {

    override func start(presentationHandler: ((Presentable) -> Void)) {
        let favoritesVM = FavoritesViewModel()
        let fvc = FavoritesViewController(viewModel: favoritesVM)
        self.router.setRootModule(fvc)
        presentationHandler(rootController)
    }
}
