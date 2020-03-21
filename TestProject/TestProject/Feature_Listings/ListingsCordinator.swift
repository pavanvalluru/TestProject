//
//  ListingsCordinator.swift
//  TestProject
//
//  Created by Pavan Kumar Valluru on 21.03.20.
//  Copyright © 2020 Pavan Kumar Valluru. All rights reserved.
//

import UIKit

class ListingsCoordinator: BaseRouterCoordinator {

    override func start(presentationHandler: ((Presentable) -> Void)) {
        let listingsVM = ListingsViewModel()
        let lvc = ListingsViewController(viewModel: listingsVM)
        self.router.setRootModule(lvc)
        presentationHandler(rootController)
    }
}
