// MockCinemaListView.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
@testable import Movie

/// Мок вью контроллера экрана со списком фильмов.
final class MockCinemaListView: CinemaListViewProtocol {

    // MARK: - public methods

    func showCinema(cinema: CinemaInfoProtocol) {}

    func showCinemaPoster(imageData: Data, posterPath: String) {}
}
