// CinemaListPresenterTest.swift
// Copyright © RoadMap. All rights reserved.

@testable import Movie
import SwiftyJSON
import XCTest

/// asdasd
class MockCinemaListView: CinemaListViewProtocol {
    func showCinema(cinema: CinemaInfoProtocol) {}

    func showCinemaPoster(imageData: Data, posterPath: String) {}
}

/// asd
class MockDataRepository: DataRepositoryProtocol {
    let cinemas: InfoAboutCinema?
    let imageData: Data

    init(cinemas: InfoAboutCinema? = nil, imageData: Data) {
        self.imageData = imageData
        self.cinemas = cinemas
    }

    func fetchCinema(typeOfCinema: TypeOfCinema, completion: @escaping (CinemaInfoProtocol) -> ()) {}

    func fetchImage(
        posterPath: String,
        size: SizeOfImages,
        completion: @escaping (Data) -> ()
    ) {}
}

/// asd
class CinemaListPresenterTest: XCTestCase {
    var view: CinemaListViewProtocol?
    var presenter: CinemaListPresenterProtocol?
    var dataRepository: MockDataRepository?
    var router: CinemaListRouterProtocol?
    var cinema: CinemaInfoProtocol?
    var imageData: Data?

    override func setUpWithError() throws {}

    override func tearDown() {
        view = nil
        dataRepository = nil
        router = nil
        imageData = nil
        cinema = nil
    }

    func testFetchCinema() throws {
        guard let jsonURL = Bundle.main.path(forResource: "CinemaResponse", ofType: "json") else { return }

        var cinemas: InfoAboutCinema?

        do {
            let fileURL = URL(fileURLWithPath: jsonURL)
            let data = try Data(contentsOf: fileURL)
            let json = try JSON(data: data)
            let cinema = InfoAboutCinema(json: json)
            cinemas = cinema
        } catch {
            print("error")
        }

        view = CinemaListViewController()
        dataRepository = MockDataRepository(cinemas: cinemas, imageData: Data())
        router = CinemaListRouter()
        presenter = CinemaListScreenPresenter(dataRepository: dataRepository, view: view, router: router)

        dataRepository?.fetchCinema(typeOfCinema: .upcomingCinema) { result in
            self.cinema = result
        }

        XCTAssertNotNil(cinemas)
    }
}
