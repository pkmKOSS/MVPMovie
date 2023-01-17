// MockCacheService.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
@testable import Movie

/// Мок сервиса кеширования.
final class MockCacheService: CacheServiceProtocol {
    // MARK: - private properties

    var data: Data?

    // MARK: - public methods

    func saveDataToCache(fileURL: String, data: Data, cacheDataType: Movie.CacheDataType) {
        self.data = data
    }

    func loadDataFromCache(fileURL: String, cacheDataType: Movie.CacheDataType) -> Data? {
        data
    }
}
