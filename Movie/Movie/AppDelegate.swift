// AppDelegate.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

@main
// Сгенерированный AppDelegate
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var navController = UIViewController()

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        KeychainService.saveAPIkey(key: "4e0be2c22f7268edffde97481d49064a")
        let cinemaListScreenBuilder = Builder()
        let viewController = cinemaListScreenBuilder.makeCinemaListModule()
        navController = UINavigationController(rootViewController: viewController)
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
        return true
    }
}
