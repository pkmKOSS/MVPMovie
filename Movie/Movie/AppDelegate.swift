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
        let cinemaListScreenBuilder = CinemaListScreenBuilder()
        let viewController = cinemaListScreenBuilder.build()
        navController = UINavigationController(rootViewController: viewController)
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
        return true
    }
}
