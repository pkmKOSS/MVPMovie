// CinemaListUITests.swift
// Copyright © RoadMap. All rights reserved.

@testable import Movie
import UIKit
import XCTest

/// Тесты представления экрана со списком фильмов
final class CinemaListUITests: XCTestCase {
    // MARK: - Private Constants

    private enum Constants {
        static let newCinema = "New"
        static let popularCinema = "Popular"
        static let upcoming = "Upcoming"
    }

    // MARK: - Public Properties

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {}

    func testExample() throws {
        let app = XCUIApplication()
        app.launch()

        app.swipeUp()
        app.swipeUp()
        app.swipeUp()

        app.tables.element.tap()
    }
}
