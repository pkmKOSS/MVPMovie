// CinemaListNetworkWorker.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Воркер для работы с сетью экрана списка фильмов.
final class CinemaListNetworkWorker: CinemaListNetworkWorkerProtocol {
    // MARK: - public properties

    var cinemaInfo: CinemaInfoProtocol?

    // MARK: - public methods

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

        NetworkManager.manager.getCinema(typeOfRequest: kindOfCinema) { result in
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
