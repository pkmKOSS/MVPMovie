// NetworkService.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire
import Foundation
import SwiftyJSON

/// Добавляет инициализатор для работы с дженерик методами в сетевом слое.
protocol JSONCodable: Codable {
    init(json: JSON)
}

/// Менеджер для работы с сетью.
final class NetworkService {
    // MARK: - public properties

    var keychainService: KeychainServiceProtocol

    // MARK: - Init

    init(keychainService: KeychainServiceProtocol) {
        self.keychainService = keychainService
    }

    private func sendRequest<T: JSONCodable>(
        urlString: String,
        model: T.Type,
        complition: @escaping (GetPostResult) -> Void
    ) {
        guard let url = URL(string: urlString) else { return }
        AF.request(url).responseJSON { response in
            switch response.result {
            case let .success(value):
                let json = JSON(value)
                complition(GetPostResult.succes(cinema: model.init(json: json)))
            case let .failure(error):
                complition(GetPostResult.failure(cinema: error))
            }
        }
    }
}

/// NetworkServiceProtocol method
extension NetworkService: NetworkServiceProtocol {
    func fetchCinema(typeOfRequest: TypeOfCinemaRequset, complition: @escaping (GetPostResult) -> Void) {
        // swiftlint: disable all
        switch typeOfRequest {
        case .getUpcoming:
            sendRequest(
                urlString: "\(URLBaseStrings.getUpcoming.rawValue)\(keychainService.decodeAPIKey())&\(URLOptionalStrings.language.rawValue)&\(URLOptionalStrings.page.rawValue)",
                model: InfoAboutCinema.self
            ) { result in
                complition(result)
            }
        case .getPopular:
            sendRequest(
                urlString: "\(URLBaseStrings.getPopular.rawValue)\(keychainService.decodeAPIKey())&\(URLOptionalStrings.language.rawValue)&\(URLOptionalStrings.page.rawValue)",
                model: InfoAboutPopularCinema.self
            ) { result in
                complition(result)
            }
        case .topRated:
            sendRequest(
                urlString: "\(URLBaseStrings.topRated.rawValue)\(keychainService.decodeAPIKey())&\(URLOptionalStrings.language.rawValue)&\(URLOptionalStrings.page.rawValue)",
                model: InfoAboutCinema.self
            ) { result in
                complition(result)
            }
        }
    }
}

/// Результат обращения к веб сервису с кинофильмами.
enum GetPostResult {
    case succes(cinema: JSONCodable)
    case failure(cinema: Error)
}

/// Результат обращения к веб сервису с кинофильмами.
enum GetImageResult {
    case succes(cinema: Data)
    case failure(cinema: Error)
}

/// Типы запроса в зависимости от получаемого контента.
enum TypeOfCinemaRequset {
    /// Получить список приближающихся релизов.
    case getUpcoming
    /// Получить список популярных картин.
    case getPopular
    /// Получить список новинок.
    case topRated
}

/// Размеры загружаемых изображений.
enum SizeOfImages: String {
    case w500
    case original
}

/// Ссылки для запросов.
enum URLBaseStrings: String {
    case getUpcoming =
        "https://api.themoviedb.org/3/movie/upcoming?api_key="
    case getPopular =
        "https://api.themoviedb.org/3/movie/popular?api_key="
    case topRated = "https://api.themoviedb.org/3/movie/top_rated?api_key="
}

/// Ссылки для запросов.
enum URLOptionalStrings: String {
    case language = "language=ru"
    case page = "page-1"
}
