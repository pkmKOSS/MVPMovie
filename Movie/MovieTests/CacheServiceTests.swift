// CacheServiceTests.swift
// Copyright © RoadMap. All rights reserved.

//
//  CacheServiceTests.swift
//  MovieTests
//
//  Created by Григоренко Александр Игоревич on 16.01.2023.
//
@testable import Movie
import XCTest

/// Тесты сервиса кеширования данных
final class CacheServiceTests: XCTestCase {
    // MARK: - private properties

    private var cacheService: CacheServiceProtocol!

    override func setUpWithError() throws {
        cacheService = CacheService()
    }

    override func tearDownWithError() throws {
        cacheService = nil
    }

    func testSaveDataToCache() throws {
        cacheService.saveDataToCache(fileURL: "testFileURL", data: Data(), cacheDataType: .images)
        let data = cacheService.loadDataFromCache(fileURL: "testFileURL", cacheDataType: .images)
        XCTAssertNotNil(data)
    }

    func testLoadDataFromCache() throws {
        cacheService.saveDataToCache(fileURL: "testFileURL", data: Data(), cacheDataType: .images)
        let data = cacheService.loadDataFromCache(fileURL: "testFileURL", cacheDataType: .images)
        XCTAssertNotNil(data)
    }
}
