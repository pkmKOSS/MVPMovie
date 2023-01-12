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
    private static func sendRequest<T: JSONCodable>(
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
    static func fetchCinema(typeOfRequest: TypeOfCinemaRequset, complition: @escaping (GetPostResult) -> Void) {
        switch typeOfRequest {
        case .getUpcoming:
            sendRequest(
                urlString: URLStrings.getUpcoming.rawValue,
                model: InfoAboutCinema.self
            ) { result in
                complition(result)
            }
        case .getPopular:
            sendRequest(
                urlString: URLStrings.getPopular.rawValue,
                model: InfoAboutPopularCinema.self
            ) { result in
                complition(result)
            }
        case .getNew:
            sendRequest(
                urlString: URLStrings.getNew.rawValue,
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
    case getNew
}

/// Размеры загружаемых изображений.
enum SizeOfImages: String {
    case w500
    case original
}

/// Ссылки для запросов.
enum URLStrings: String {
    case getUpcoming =
        "https://api.themoviedb.org/3/movie/upcoming?api_key=4e0be2c22f7268edffde97481d49064a&language=ru&page-1"
    case getPopular =
        "https://api.themoviedb.org/3/movie/popular?api_key=4e0be2c22f7268edffde97481d49064a&language=ru&page-2"
    case getNew = "https://api.themoviedb.org/3/movie/latest?4e0be2c22f7268edffde97481d49064a&language=ru&page-3"
}
