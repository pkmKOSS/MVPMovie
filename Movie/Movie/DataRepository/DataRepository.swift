// DataRepository.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Воркер для работы с сетью экрана списка фильмов.
final class DataRepository: DataRepositoryProtocol {
    // MARK: - private properties

    var dataBaseService: DataBaseService?
    var cacheService: CacheService?

    // MARK: - init

    init(dataBaseService: DataBaseService, cacheService: CacheService) {
        self.dataBaseService = dataBaseService
        self.cacheService = cacheService
    }

    // MARK: - public methods

    func fetchImage(posterPath: String, size: SizeOfImages, completion: @escaping (Data) -> ()) {
        if let imageData = cacheService?.loadDataFromCache(fileURL: posterPath, cacheDataType: .images) {
            completion(imageData)
        } else {
            ImageService.getImage(
                posterPath: posterPath,
                size: size
            ) { result in
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
                return .getNew
            case .upcomingCinema:
                return .getUpcoming
            }
        }()

        NetworkService.fetchCinema(typeOfRequest: kindOfCinema) { result in
            if
                let cachedCinema = self.dataBaseService?.loadData(objectType: Result.self),
                cachedCinema.count != 0
            {
                completion(CinemaLibrary(results: cachedCinema))
            } else {
                switch result {
                case let .succes(cinema):
                    guard let cinemaResponse = cinema as? CinemaInfoProtocol else { return }
                    self.dataBaseService?.saveData(objects: cinemaResponse.results)
                    completion(cinemaResponse)
                case let .failure(cinema):
                    print("error: - \(cinema.localizedDescription)")
                }
            }
        }
    }
}
