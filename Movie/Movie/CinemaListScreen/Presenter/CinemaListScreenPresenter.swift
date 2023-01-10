// CinemaListScreenPresenter.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Презентер экрана со списков фильмов
final class CinemaListScreenPresenter: CinemaListPresenterProtocol {
    // MARK: - public properties

    var worker: CinemaListNetworkWorkerProtocol!
    var viewController: CinemaListViewProtocol!
    var router: CinemaListRouterProtocol!

    // MARK: - public methods

    func fetchCinema(typeOfCinema: TypeOfCinema) {
        worker.fetchCinema(typeOfCinema: typeOfCinema) { response in
            self.presentCinema(cinema: response)
        }
    }

    func presentCinema(cinema: CinemaInfoProtocol) {
        viewController.showCinema(cinema: cinema)
    }

    func fetchImage(
        posterPath: String,
        size: SizeOfImages
    ) {
        worker.getImage(posterPath: posterPath, size: size) { [weak self] data in
            guard let self = self else { return }
            self.viewController.showCinemaPoster(imageData: data, posterPath: posterPath)
        }
    }

    func routToDescription(
        cinemaDescription: CinemaDescription,
        posterData: Data,
        rootViewController: CinemaListViewProtocol
    ) {
        router.routTo(description: cinemaDescription, imageData: posterData, rootViewController: rootViewController)
    }
}
