// Builder.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Создает экран со списком фильмов.
final class Builder: AssemblyBuilderProtocol {
    // MARK: - public methods

    func makeCinemaListModule() -> UIViewController {
        let presenter = CinemaListScreenPresenter()
        let dataBaseService = DataBaseService()
        let cacheService = CacheService()
        let keychainService = KeychainService()
        let imageService = ImageService()
        let networkService = NetworkService(keychainService: keychainService)
        let dataRepository = DataRepository(
            dataBaseService: dataBaseService,
            cacheService: cacheService,
            networkService: networkService,
            imageService: imageService
        )
        let router = CinemaListRouter()
        let viewController = CinemaListViewController()
        viewController.presenter = presenter
        presenter.dataRepository = dataRepository
        presenter.router = router
        presenter.view = viewController
        return viewController
    }

    func makeCinemaDescriptionModule(
        cinemaDescription: CinemaDescription,
        posterData: Data
    ) -> UIViewController {
        let router = CinemaDescriptionRouter()
        let presenter = CinemaDescriptionPresenter(router: router)
        let viewController = CinemaDescriptionViewController(
            helper: cinemaDescription,
            posterData: posterData,
            presenter: presenter
        )
        presenter.router = router
        presenter.view = viewController
        return viewController
    }
}
