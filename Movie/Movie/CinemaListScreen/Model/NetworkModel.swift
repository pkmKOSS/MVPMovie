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

    init(json: JSON) {
        dates = Dates(maximum: json["dates", "maximum"].stringValue, minimum: json["dates", "minimum"].stringValue)
        page = json["page"].intValue
        results = json["results"].arrayValue.map { Result(json: $0) }
        totalPages = json["totalPages"].intValue
        totalResults = json["totalResults"].intValue
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

    init(json: JSON) {
        page = json["page"].intValue
        totalPages = json["totalPages"].intValue
        totalResults = json["totalResults"].intValue
        results = json["results"].arrayValue.map { Result(json: $0) }
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

    init(
        json: JSON
    ) {
        adult = json["adult"].boolValue
        backdropPath = json["backdropPath"].stringValue
        genreIDS = []
        id = json["id"].intValue
        originalLanguage = json["originalLanguage"].stringValue
        originalTitle = json["originalTitle"].stringValue
        overview = json["overview"].stringValue
        popularity = json["popularity"].doubleValue
        posterPath = json["poster_path"].stringValue
        releaseDate = json["releaseDate"].stringValue
        title = json["title"].stringValue
        video = json["video"].boolValue
        voteAverage = json["vote_average"].doubleValue
        voteCount = json["vote_count"].intValue
    }
}
