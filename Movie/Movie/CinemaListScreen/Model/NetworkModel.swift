// NetworkModel.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import SwiftyJSON

/// Сведения о грядущих новинках.
struct InfoAboutCinema: JSONCodable, CinemaInfoProtocol {
    let dates: Dates
    let page: Int
    let totalPages, totalResults: Int
    var results: [Result]

    init(json: SwiftyJSON.JSON) {
        dates = Dates(maximum: json["dates", "maximum"].stringValue, minimum: json["dates", "minimum"].stringValue)
        page = json["page"].intValue
        results = json["results"].arrayValue.map { result in
            Result(
                adult: result["adult"].boolValue,
                backdropPath: result["backdropPath"].stringValue,
                genreIDS: [],
                id: result["id"].intValue,
                originalLanguage: result["originalLanguage"].stringValue,
                originalTitle: result["originalTitle"].stringValue,
                overview: result["overview"].stringValue,
                popularity: result["popularity"].doubleValue,
                posterPath: result["poster_path"].stringValue,
                releaseDate: result["releaseDate"].stringValue,
                title: result["title"].stringValue,
                video: result["video"].boolValue,
                voteAverage: result["vote_average"].doubleValue,
                voteCount: result["vote_count"].intValue
            )
        }
        totalPages = json["totalPages"].intValue
        totalResults = json["totalResults"].intValue
    }

    enum CodingKeys: String, CodingKey {
        case dates, page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

/// Сведения о популярных кинофильмах.
struct InfoAboutPopularCinema: JSONCodable, CinemaInfoProtocol {
    /// Номер страницы
    let page: Int
    /// Всего страниц и всего результатов
    let totalPages, totalResults: Int
    /// Результаты - массив с фильмами.
    var results: [Result]

    init(json: SwiftyJSON.JSON) {
        page = json["page"].intValue
        totalPages = json["totalPages"].intValue
        totalResults = json["totalResults"].intValue
        results = json["results"].arrayValue.map { result in
            Result(
                adult: result["adult"].boolValue,
                backdropPath: result["backdropPath"].stringValue,
                genreIDS: [],
                id: result["id"].intValue,
                originalLanguage: result["originalLanguage"].stringValue,
                originalTitle: result["originalTitle"].stringValue,
                overview: result["overview"].stringValue,
                popularity: result["popularity"].doubleValue,
                posterPath: result["posterPath"].stringValue,
                releaseDate: result["releaseDate"].stringValue,
                title: result["title"].stringValue,
                video: result["video"].boolValue,
                voteAverage: result["vote_average"].doubleValue,
                voteCount: result["vote_count"].intValue
            )
        }
    }

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

/// Даты выхода грядущего релиза.
struct Dates: Codable {
    let maximum, minimum: String
}

/// Сведения о конкретном фильме.
struct Result: Codable {
    /// Любительский ли фильм
    let adult: Bool
    /// Адрес фонового изображения
    let backdropPath: String
    /// Массив с ID жанров
    let genreIDS: [Int]
    /// ID фильма.
    let id: Int
    /// Оригинальный язык, оригинальное название, оригинально описание
    let originalLanguage, originalTitle, overview: String
    /// Популярность
    let popularity: Double
    /// Адрес изображения постера, дата релиза, название
    let posterPath, releaseDate, title: String
    /// Есть ли трейлер
    let video: Bool
    /// Средняя оценка
    let voteAverage: Double
    /// Количество оценок
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
