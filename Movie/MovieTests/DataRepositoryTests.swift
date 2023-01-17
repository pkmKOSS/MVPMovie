// DataRepositoryTests.swift
// Copyright © RoadMap. All rights reserved.

@testable import Movie
import XCTest

/// Тесты репозитория данных
final class DataRepositoryTests: XCTestCase {
    // MARK: - private constants

    private enum Constants {
        static let posterPathName = "posterPath"
    }

    // MARK: - private properties

    private var dataRepository: DataRepositoryProtocol!
    private var dataBaseService: DataBaseServiceProtocol!
    private var cacheService: CacheServiceProtocol!
    private var networkService: NetworkServiceProtocol!
    private var imageService: ImageServiceProtocol!
    private var keychainService: KeychainServiceProtocol!
    private var responsex: CinemaInfoProtocol!

    // MARK: - Public methods

    override func setUpWithError() throws {
        dataBaseService = MockDataBaseService()
        cacheService = MockCacheService()
        keychainService = MockKeychainService()
        networkService = MockNetworkService(keychainService: KeychainService())
        imageService = MockImageServiceTests(posterPath: Constants.posterPathName)

        dataRepository = DataRepository(
            dataBaseService: dataBaseService,
            cacheService: cacheService,
            networkService: networkService,
            imageService: imageService
        )
    }

    override func tearDownWithError() throws {
        dataBaseService = nil
        cacheService = nil
        keychainService = nil
        networkService = nil
        imageService = nil
        dataRepository = nil
    }

    func testFetchImage() {
        var imagData: Data?
        dataRepository.fetchImage(posterPath: Constants.posterPathName, size: .w500) { data in
            imagData = data
            XCTAssertNotNil(imagData)
        }
    }

    func testFetchCinema() {
        dataRepository.fetchCinema(typeOfCinema: .upcomingCinema) { response in
            self.responsex = response
            XCTAssertNotNil(self.responsex)
        }
    }
}
