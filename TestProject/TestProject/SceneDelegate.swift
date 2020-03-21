//
//  SceneDelegate.swift
//  TestProject
//
//  Created by Pavan Kumar Valluru on 21.03.20.
//  Copyright © 2020 Pavan Kumar Valluru. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator!

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        appCoordinator = AppCoordinator()
        appCoordinator.start { controller in
            window?.rootViewController = controller as? UIViewController
            window?.makeKeyAndVisible()
        }

        setupNavigationBarAppearance()
    }
}

private extension SceneDelegate {

    func setupNavigationBarAppearance() {
        let appearance = UINavigationBarAppearance()
        // background color
        appearance.backgroundColor = GlobalConstants.appThemeColor
        // title color
        appearance.titleTextAttributes = [.foregroundColor: GlobalConstants.appTintColor]
        // large title color
        appearance.largeTitleTextAttributes = [.foregroundColor: GlobalConstants.appThemeColor]
        // bar button styling
        let barButtonItemApperance = UIBarButtonItemAppearance()
        barButtonItemApperance.normal.titleTextAttributes = [.foregroundColor: GlobalConstants.appTintColor]

        appearance.backButtonAppearance = barButtonItemApperance
        appearance.doneButtonAppearance = barButtonItemApperance
        appearance.buttonAppearance = barButtonItemApperance

        // set the navigation bar appearance to the color we have set above
        UINavigationBar.appearance().standardAppearance = appearance

        // when the navigation bar has a neighbouring scroll view item (eg: scroll view, table view etc)
        // the "scrollEdgeAppearance" will be used
        // by default, scrollEdgeAppearance will have a transparent background
        UINavigationBar.appearance().scrollEdgeAppearance = appearance

        UITabBar.appearance().tintColor = GlobalConstants.appTintColor
    }
}
