// MockBuilder.swift
// Copyright © RoadMap. All rights reserved.

@testable import Movie
import UIKit

/// Мок билдера
final class MockBuilder: AssemblyBuilderProtocol {
    
    // MARK: - public properties

    func makeCinemaListModule() -> UIViewController {
        CinemaListViewController()
    }

    func makeCinemaDescriptionModule(cinemaDescription: Movie.CinemaDescription, posterData: Data) -> UIViewController {
        let router = CinemaDescriptionRouter()
        let presenter = CinemaDescriptionPresenter(router: router)
        return CinemaDescriptionViewController(
            helper: CinemaDescription(
                title: "bar",
                modelOverview: "bazz",
                modelVoteAverage: 2200,
                modelVoteCount: 200,
                posterPath: "somePath"
            ),
            posterData: Data(),
            presenter: presenter
        )
    }
}
