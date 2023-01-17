// DataBaseServiceTests.swift
// Copyright © RoadMap. All rights reserved.

@testable import Movie
import Realm
import RealmSwift
import SwiftyJSON
import XCTest

/// Тесты сервиса работы с данными.
final class DataBaseServiceTests: XCTestCase {
    // MARK: - private properties

    private var dataBaseService: DataBaseServiceProtocol!
    private var jsonURL: String!

    // MARK: - public methods

    override func setUpWithError() throws {
        dataBaseService = DataBaseService()
        jsonURL = Bundle.main.path(forResource: "CinemaResponse", ofType: "json") ?? ""
    }

    override func tearDownWithError() throws {
        dataBaseService = nil
    }

    func testSaveData() throws {
        do {
            let fileURL = URL(fileURLWithPath: jsonURL)
            let data = try Data(contentsOf: fileURL)
            let json = try JSON(data: data)
            dataBaseService.saveData(objects: [Result(json: json)])
            let loadedData = dataBaseService.loadData(objectType: Result.self)
            XCTAssertNotNil(loadedData)
        }
    }

    func testLoadData() throws {
        do {
            let fileURL = URL(fileURLWithPath: jsonURL)
            let data = try Data(contentsOf: fileURL)
            let json = try JSON(data: data)
            dataBaseService.saveData(objects: [Result(json: json)])
            let loadedData = dataBaseService.loadData(objectType: Result.self)
            XCTAssertNotNil(loadedData)
        }
    }
}
