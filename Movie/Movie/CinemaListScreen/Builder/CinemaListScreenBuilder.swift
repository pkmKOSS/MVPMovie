// CinemaListScreenBuilder.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Создает экран со списком фильмов.
final class CinemaListScreenBuilder: CinemaListScreenBuilderProtocol {
    // MARK: - public methods

    func build() -> CinemaListViewController {
        let presenter = CinemaListScreenPresenter()
        let worker = CinemaListNetworkWorker()
        let viewController = CinemaListViewController()
        let router = CinemaListRouter()
        viewController.presenter = presenter
        presenter.worker = worker
        presenter.router = router
        presenter.viewController = viewController
        return viewController
    }
}
