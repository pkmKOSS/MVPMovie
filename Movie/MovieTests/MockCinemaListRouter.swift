// MockCinemaListRouter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
@testable import Movie

/// Мок роутера экрана со списком фильмов.
final class MockCinemaListRouter: CinemaListRouterProtocol {

    // MARK: - Init

    init() {}

    // MARK: - public methods

    func routTo(
        description: Movie.CinemaDescription,
        imageData: Data,
        rootViewController: Movie.CinemaListViewProtocol
    ) {}
}
