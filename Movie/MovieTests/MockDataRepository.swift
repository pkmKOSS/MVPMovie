// MockDataRepository.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
@testable import Movie

// Мок дата репозитория.
final class MockDataRepository: DataRepositoryProtocol {
    // MARK: - Private properties

    private let cinemas: InfoAboutCinema?
    private let networkService: NetworkServiceProtocol
    private let dataBaseService: DataBaseServiceProtocol
    private let imageService: ImageServiceProtocol

    // MARK: - Init

    init(
        cinemas: InfoAboutCinema? = nil,
        imageData: Data? = nil,
        networkService: NetworkServiceProtocol,
        dataBaseService: DataBaseServiceProtocol,
        imageService: ImageServiceProtocol
    ) {
        self.networkService = networkService
        self.cinemas = cinemas
        self.dataBaseService = dataBaseService
        self.imageService = imageService
    }

    // MARK: - public methods

    func fetchCinema(typeOfCinema: TypeOfCinema, completion: @escaping (CinemaInfoProtocol) -> ()) {
        let kindOfCinema: TypeOfCinemaRequset = {
            switch typeOfCinema {
            case .popularCinema:
                return .getPopular
            case .newCinema:
                return .topRated
            case .upcomingCinema:
                return .getUpcoming
            }
        }()

        networkService.fetchCinema(typeOfRequest: kindOfCinema) { result in
            switch result {
            case let .succes(cinema):
                if let cinemaResponse = cinema as? CinemaInfoProtocol {
                    self.dataBaseService.saveData(objects: cinemaResponse.results)
                    completion(cinemaResponse)
                }
            case let .failure(error):
                print("error: - \(error.localizedDescription)")
            }
        }
    }

    func fetchImage(
        posterPath: String,
        size: SizeOfImages,
        completion: @escaping (Data) -> ()
    ) {
        imageService.fetchImage(posterPath: posterPath, size: size) { result in
            switch result {
            case let .succes(data):
                completion(data)
            default: break
            }
        }
    }
}
