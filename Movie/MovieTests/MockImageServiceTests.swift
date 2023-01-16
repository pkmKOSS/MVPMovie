// MockImageServiceTests.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire
import Foundation
@testable import Movie

/// Мок сервиса загрузки изображений
final class MockImageServiceTests: ImageServiceProtocol {

    // MARK: - private properties

    private let posterPath: String?

    // MARK: - init

    init(posterPath: String) {
        self.posterPath = posterPath
    }

    // MARK: - public methpds

    func fetchImage(
        posterPath: String,
        size: Movie.SizeOfImages,
        complition: @escaping (Movie.GetImageResult) -> Void
    ) {
        complition(GetImageResult.succes(cinema: Data()))
    }
}
