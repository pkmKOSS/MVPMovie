// MockNetworkService.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
@testable import Movie
import SwiftyJSON

/// Мок сервиса работы с сетью.
final class MockNetworkService: NetworkServiceProtocol {
    // MARK: - public properties

    var keychainService: KeychainServiceProtocol
    var jsonPath: String?
    var json: JSON?

    // MARK: - init

    init(keychainService: KeychainServiceProtocol!) {
        self.keychainService = keychainService
    }

    // MARK: - public methods

    func fetchCinema(typeOfRequest: Movie.TypeOfCinemaRequset, completion: @escaping (Movie.GetPostResult) -> Void) {
        jsonPath = Bundle.main.path(forResource: "CinemaResponse", ofType: "json")
        do {
            let fileURL = URL(fileURLWithPath: jsonPath ?? "")
            if let data = try? Data(contentsOf: fileURL),
               let json = try? JSON(data: data) { completion(GetPostResult.succes(cinema: Result(json: json))) }
        }

        // swiftlint: disable all
        switch typeOfRequest {
        case .getUpcoming:
            sendRequest(
                urlString: "\(URLBaseStrings.getUpcoming.rawValue)\(keychainService.decodeAPIKey())&\(URLOptionalStrings.language.rawValue)&\(URLOptionalStrings.page.rawValue)",
                model: InfoAboutCinema.self
            ) { result in
                completion(result)
            }
        case .getPopular:
            sendRequest(
                urlString: "\(URLBaseStrings.getPopular.rawValue)\(keychainService.decodeAPIKey())&\(URLOptionalStrings.language.rawValue)&\(URLOptionalStrings.page.rawValue)",
                model: InfoAboutPopularCinema.self
            ) { result in
                completion(result)
            }
        case .topRated:
            sendRequest(
                urlString: "\(URLBaseStrings.topRated.rawValue)\(keychainService.decodeAPIKey())&\(URLOptionalStrings.language.rawValue)&\(URLOptionalStrings.page.rawValue)",
                model: InfoAboutCinema.self
            ) { result in
                completion(result)
            }
        }
    }

    func sendRequest<T>(
        urlString: String,
        model: T.Type,
        completion: @escaping (GetPostResult) -> Void
    ) where T: JSONCodable {
        if let json = json {
            completion(GetPostResult.succes(cinema: model.init(json: json)))
        }
    }
}
