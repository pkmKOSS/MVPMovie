// CinemaListRouter.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Роутер экрана списка с фильмами.
final class CinemaListRouter: CinemaListRouterProtocol {
    // MARK: - Public methods

    func routTo(description: CinemaDescription, imageData: Data, rootViewController: CinemaListViewProtocol) {
        let cinemaDescriptionScreenBuilder = CinemaDescriptionBuilder()
        let cinemaDescriptionScreenVC = cinemaDescriptionScreenBuilder.build(
            cinemaDescription: description,
            posterData: imageData
        )
        guard
            let rootViewController = rootViewController as? UIViewController,
            let cinemaDescriptionScreenVC = cinemaDescriptionScreenVC as? UIViewController
        else { return }
        rootViewController.navigationController?.pushViewController(
            cinemaDescriptionScreenVC,
            animated: true
        )
    }
}
