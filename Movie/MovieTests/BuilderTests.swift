// BuilderTests.swift
// Copyright © RoadMap. All rights reserved.

@testable import Movie
import XCTest

/// Тесты билдера
final class BuilderTests: XCTestCase {
    // MARK: - Private properties

    private var builder: AssemblyBuilderProtocol!

    // MARK: - Public methods

    override func setUpWithError() throws {
        builder = Builder()
    }

    override func tearDownWithError() throws {
        builder = nil
    }

    func testMakeCinemaListModule() {
        let isModuleIsCinemaListModule = builder.makeCinemaListModule() is CinemaListViewController
        XCTAssertTrue(isModuleIsCinemaListModule)
    }

    func testMakeCinemaDescriptionModule() {
        let description = CinemaDescription(
            title: "title",
            modelOverview: "modelOverview",
            modelVoteAverage: 200,
            modelVoteCount: 10,
            posterPath: "posterPath"
        )
        let isModuleIsCinemaDescriptionModule = builder.makeCinemaDescriptionModule(
            cinemaDescription: description,
            posterData: Data()
        ) is CinemaDescriptionViewController
        XCTAssertTrue(isModuleIsCinemaDescriptionModule)
    }
}
