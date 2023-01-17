// CinemaListPresenterTest.swift
// Copyright © RoadMap. All rights reserved.

@testable import Movie
import SwiftyJSON
import XCTest

/// Тесты презентера экрана со списком фильмов
final class CinemaListPresenterTest: XCTestCase {
    // MARK: - private constants

    private enum Constants {
        static let posterPathName = "posterPath"
        static let cinemaResponseName = "CinemaResponse"
        static let jsonTypeName = "json"
        static let defaultStringName = ""
    }

    // MARK: - private properties

    private var view: CinemaListViewProtocol!
    private var presenter: CinemaListPresenterProtocol!
    private var dataBaseService: DataBaseServiceProtocol!
    private var dataRepository: DataRepositoryProtocol!
    private var keychainService: KeychainServiceProtocol!
    private var networkService: NetworkServiceProtocol!
    private var imageService: ImageServiceProtocol!
    private var router: CinemaListRouterProtocol!
    private var cinema: CinemaInfoProtocol!
    private var imageData: Data?
    private var jsonURL: String!
    private var cinemas: InfoAboutCinema?

    // MARK: - public methods

    override func setUpWithError() throws {
        keychainService = MockKeychainService()
        imageService = MockImageServiceTests(posterPath: Constants.posterPathName)
        dataBaseService = MockDataBaseService()
        networkService = MockNetworkService(keychainService: keychainService)
        jsonURL = Bundle.main
            .path(forResource: Constants.cinemaResponseName, ofType: Constants.jsonTypeName) ?? Constants
            .defaultStringName
        do {
            let fileURL = URL(fileURLWithPath: jsonURL)
            let data = try Data(contentsOf: fileURL)
            let json = try JSON(data: data)
            let cinema = InfoAboutCinema(json: json)
            cinemas = cinema
        }
        dataRepository = MockDataRepository(
            networkService: networkService,
            dataBaseService: dataBaseService,
            imageService: imageService
        )
        router = MockCinemaListRouter()
        view = MockCinemaListView()
    }

    override func tearDown() {
        view = nil
        dataRepository = nil
        router = nil
        imageData = nil
        cinema = nil
    }

    func testFetchCinema() throws {
        dataRepository.fetchCinema(typeOfCinema: .newCinema) { result in
            self.cinema = result
            XCTAssertNotNil(self.cinemas)
        }

        dataRepository.fetchCinema(typeOfCinema: .upcomingCinema) { result in
            self.cinema = result
            XCTAssertNotNil(self.cinemas)
        }

        dataRepository.fetchCinema(typeOfCinema: .popularCinema) { result in
            self.cinema = result
            XCTAssertNotNil(self.cinemas)
        }
    }

    func testFetchImage() throws {
        var imageData: Data?

        dataRepository?.fetchImage(posterPath: "bar", size: .w500, completion: { data in
            imageData = data
            XCTAssertNotNil(imageData)
        })
    }
}
