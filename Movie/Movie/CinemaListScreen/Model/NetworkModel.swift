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
        print(json)
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
    let page: Int
    let totalPages, totalResults: Int
    var results: [Result]

    init(json: SwiftyJSON.JSON) {
        print(json)
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
    let adult: Bool
    let backdropPath: String
    let genreIDS: [Int]
    let id: Int
    let originalLanguage, originalTitle, overview: String
    let popularity: Double
    let posterPath, releaseDate, title: String
    let video: Bool
    let voteAverage: Double
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
