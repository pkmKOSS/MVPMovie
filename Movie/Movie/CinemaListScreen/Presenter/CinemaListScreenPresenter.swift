// CinemaListScreenPresenter.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Презентер экрана со списков фильмов
final class CinemaListScreenPresenter: CinemaListPresenterProtocol {
    // MARK: - public properties

    var dataRepository: DataRepositoryProtocol?
    var router: CinemaListRouterProtocol?
    weak var view: CinemaListViewProtocol?

    // MARK: - init

    init(
        dataRepository: DataRepositoryProtocol? = nil,
        view: CinemaListViewProtocol? = nil,
        router: CinemaListRouterProtocol? = nil
    ) {
        self.dataRepository = dataRepository
        self.view = view
        self.router = router
    }

    // MARK: - public methods

    func fetchCinema(typeOfCinema: TypeOfCinema) {
        dataRepository?.fetchCinema(typeOfCinema: typeOfCinema) { [weak self] response in
            guard let self = self else { return }
            self.presentCinema(cinema: response)
        }
    }

    func presentCinema(cinema: CinemaInfoProtocol) {
        view?.showCinema(cinema: cinema)
    }

    func fetchImage(
        posterPath: String,
        size: SizeOfImages
    ) {
        dataRepository?.fetchImage(posterPath: posterPath, size: size) { [weak self] data in
            guard let self = self else { return }
            self.view?.showCinemaPoster(imageData: data, posterPath: posterPath)
        }
    }

    func routToDescription(
        cinemaDescription: CinemaDescription,
        posterData: Data,
        rootViewController: CinemaListViewProtocol
    ) {
        router?.routTo(description: cinemaDescription, imageData: posterData, rootViewController: rootViewController)
    }
}
