// Builder.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Создает экран со списком фильмов.
final class Builder: AssemblyBuilderProtocol {
    func makeCinemaListModule() -> UIViewController {
        let presenter = CinemaListScreenPresenter()
        let worker = DataRepository()
        let router = CinemaListRouter()
        let viewController = CinemaListViewController()
        viewController.presenter = presenter
        presenter.dataRepository = worker
        presenter.router = router
        presenter.view = viewController
        return viewController
    }

    func makeCinemaDescriptionModule(
        cinemaDescription: CinemaDescription,
        posterData: Data
    ) -> UIViewController {
        let router = CinemaDescriptionRouter()
        let viewController = CinemaDescriptionViewController(helper: cinemaDescription, posterData: posterData)
        let presenter = CinemaDescriptionPresenter(view: viewController, router: router)
        presenter.router = router
        viewController.presenter = presenter
        return viewController
    }
}
