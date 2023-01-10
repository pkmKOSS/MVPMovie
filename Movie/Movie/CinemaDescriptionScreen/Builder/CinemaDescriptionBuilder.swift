// CinemaDescriptionBuilder.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Билдер экрана с подробностями о фильме.
final class CinemaDescriptionBuilder: CinemaDescriptionBuilderProtocol {
    // MARK: - Public methods

    func build(cinemaDescription: CinemaDescription, posterData: Data) -> CinemaDescriptionViewProtocol {
        let presenter = CinemaDescriptionPresenter()
        let viewController = CinemaDescriptionViewController(helper: cinemaDescription, posterData: posterData)
        viewController.presenter = presenter
        return viewController
    }
}
