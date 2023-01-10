// CinemaListNetworkWorker.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Воркер для работы с сетью экрана списка фильмов.
class CinemaListNetworkWorker: CinemaListNetworkWorkerProtocol {
    func getImage(posterPath: String, size: SizeOfImages, completion: @escaping (Data) -> ()) {
        NetworkManager.manager.getImage(
            posterPath: posterPath,
            size: size
        ) { result in
            switch result {
            case let .succes(data):
                completion(data)
            case let .failure(cinema):
                print(cinema.localizedDescription)
            }
        }
    }

    var cinemaInfo: CinemaInfoProtocol?

    func fetchCinema(completion: @escaping (CinemaInfoProtocol) -> ()) {
        NetworkManager.manager.getCinema(typeOfRequest: .getPopular) { result in
            switch result {
            case let .succes(cinema):
                guard let cinemaResponse = cinema as? CinemaInfoProtocol else { return }
                completion(cinemaResponse)
            case let .failure(cinema):
                print("error: - \(cinema.localizedDescription)")
            }
        }
    }
}
