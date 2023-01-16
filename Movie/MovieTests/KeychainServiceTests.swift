// KeychainServiceTests.swift
// Copyright © RoadMap. All rights reserved.

@testable import Movie
import XCTest

/// Тесты сервиса работы с зашифрованными данными
final class KeychainServiceTests: XCTestCase {
    // MARK: - private properties

    private var keychainService: KeychainServiceProtocol!

    // MARK: - public methods

    override func setUpWithError() throws {
        keychainService = KeychainService()
    }

    override func tearDownWithError() throws {
        keychainService.updateAPI(key: "4e0be2c22f7268edffde97481d49064a")
        keychainService = nil
    }

    func testUpdateAPI() throws {
        let oldAPIKey = keychainService.decodeAPIKey()
        keychainService.updateAPI(key: "11115555500000")
        let newAPIKey = keychainService.decodeAPIKey()

        let isAPIKeysEqual = oldAPIKey == newAPIKey

        XCTAssertFalse(isAPIKeysEqual)
    }

    func testSaveAPIKey() {
        let oldAPIKey = keychainService.decodeAPIKey()
        keychainService.deleteAPIKey(key: oldAPIKey)
        keychainService.saveAPIkey(key: "123123123")
        let newAPIKey = keychainService.decodeAPIKey()

        XCTAssertNotEqual(oldAPIKey, newAPIKey)
    }

    func testDecodeAPIKey() {
        var apiKey: String?
        apiKey = keychainService.decodeAPIKey()

        XCTAssertNotNil(apiKey)
    }
}
