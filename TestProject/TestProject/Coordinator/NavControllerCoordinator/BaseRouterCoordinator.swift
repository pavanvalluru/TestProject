//
//  BaseRouterCoordinator.swift
//  TestProject
//
//  Created by Pavan Kumar Valluru on 21.03.20.
//  Copyright © 2020 Pavan Kumar Valluru. All rights reserved.
//

import UIKit

class BaseRouterCoordinator: Coordinator {

    // MARK: - Vars & Lets
    let rootController: UINavigationController
    var childCoordinators = [Coordinator]()
    let router: RouterProtocol

    // if the presentation style changes or any other customisation,
    // then we need to pass our own Navigation Controller otherwise default would be fine
    init(usingNavController: UINavigationController = UINavigationController()) {
        self.rootController = usingNavController
        self.router = Router(rootController: usingNavController)
    }

    // MARK: - Coordinator

    func start(presentationHandler: ((Presentable) -> Void)) {
        fatalError("Children should implement `start(presentationHandler)`.")
    }
}
