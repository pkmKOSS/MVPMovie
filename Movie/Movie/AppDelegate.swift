// AppDelegate.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

@main
// Сгенерированный AppDelegate
class AppDelegate: UIResponder, UIApplicationDelegate {
    // MARK: - Private constant

    private enum Constants {
        static let apiKey = "4e0be2c22f7268edffde97481d49064a"
    }

    // MARK: Public properties

    var window: UIWindow?
    var navController = UIViewController()

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        KeychainService.saveAPIkey(key: Constants.apiKey)
        let cinemaListScreenBuilder = Builder()
        let viewController = cinemaListScreenBuilder.makeCinemaListModule()
        navController = UINavigationController(rootViewController: viewController)
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
        return true
    }
}
