// CinemaDescriptionViewTest.swift
// Copyright © RoadMap. All rights reserved.

@testable import Movie
import XCTest

/// Тесты представления экрана с описанием фильма.
final class CinemaDescriptionViewTest: XCTestCase {

    // MARK: - private constants

    private enum Constant {
        static let titleName = "title"
        static let modelOverviewName = "modelOverview"
        static let modelVoteAverage = 22
        static let modelVoteCount = 22
        static let posterPathName = "posterPath"
        static let defaultString = "SomeText"
    }

    // MARK: - public properties

    var cinemaDescriptionViewController: CinemaDescriptionViewProtocol!

    // MARK: - public methods

    override func setUpWithError() throws {
        let router = CinemaDescriptionRouter()
        let presenter = CinemaDescriptionPresenter(router: router)
        cinemaDescriptionViewController = CinemaDescriptionViewController(
            helper: CinemaDescription(
                title: Constant.titleName,
                modelOverview: Constant.modelOverviewName,
                modelVoteAverage: Constant.modelVoteAverage,
                modelVoteCount: Constant.modelVoteCount,
                posterPath: Constant.posterPathName
            ),
            posterData: Data(),
            presenter: presenter
        )
        presenter.view = cinemaDescriptionViewController
    }

    override func tearDownWithError() throws {
        cinemaDescriptionViewController = nil
    }

    func testExample() throws {
        cinemaDescriptionViewController.hellow()
    }

    func testCell() throws {
        let cell = ButtonsTableViewCell()
        cell.configureCell()
    }

    func testRatingCell() {
        let cell = RatingTableViewCell()
        cell.configure(countOfVote: 100, avarageVote: 100)
    }

    func testOverviewCell() {
        let cell = OverviewTableViewCell()
        cell.configureCell(overViewText: Constant.defaultString)
    }

    func testPosterCell() {
        let cell = PosterTableViewCell()
        cell.configureCell(imageData: Data())
    }
}
