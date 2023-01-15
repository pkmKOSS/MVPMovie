// DataRepository.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Репозиторий для работы с сетью экрана списка фильмов.
final class DataRepository: DataRepositoryProtocol {
    // MARK: - properties

    private var dataBaseService: DataBaseServiceProtocol?
    private var cacheService: CacheServiceProtocol?
    private var networkService: NetworkServiceProtocol

    // MARK: - init

    init(
        dataBaseService: DataBaseServiceProtocol,
        cacheService: CacheServiceProtocol,
        networkService: NetworkServiceProtocol
    ) {
        self.dataBaseService = dataBaseService
        self.cacheService = cacheService
        self.networkService = networkService
    }

    // MARK: - public methods

    func fetchImage(posterPath: String, size: SizeOfImages, completion: @escaping (Data) -> ()) {
        if let imageData = cacheService?.loadDataFromCache(fileURL: posterPath, cacheDataType: .images) {
            completion(imageData)
        } else {
            ImageService.fetchImage(
                posterPath: posterPath,
                size: size
            ) { [weak self] result in
                guard let self else { return }
                switch result {
                case let .succes(data):
                    self.cacheService?.saveDataToCache(fileURL: posterPath, data: data, cacheDataType: .images)
                    completion(data)
                case let .failure(cinema):
                    print(cinema.localizedDescription)
                }
            }
        }
    }

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
                guard let cinemaResponse = cinema as? CinemaInfoProtocol else { return }
                self.dataBaseService?.saveData(objects: cinemaResponse.results)
                completion(cinemaResponse)
            case let .failure(cinema):
                print("error: - \(cinema.localizedDescription)")
            }
        }

        guard
            let cachedCinema = dataBaseService?.loadData(objectType: Result.self),
            cachedCinema.count != 0
        else {
            networkService.fetchCinema(typeOfRequest: kindOfCinema) { result in
                switch result {
                case let .succes(cinema):
                    guard let cinemaResponse = cinema as? CinemaInfoProtocol else { return }
                    self.dataBaseService?.saveData(objects: cinemaResponse.results)
                    completion(cinemaResponse)
                case let .failure(cinema):
                    print("error: - \(cinema.localizedDescription)")
                }
            }
            return
        }
        completion(CinemaLibrary(results: cachedCinema))
    }
}
