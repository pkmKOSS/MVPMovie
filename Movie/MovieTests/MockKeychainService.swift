// MockKeychainService.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
@testable import Movie

/// Мок сервиса работы с зашифрованными данными
final class MockKeychainService: KeychainServiceProtocol {
    // MARK: - public methods

    func updateAPI(key: String) {}

    func saveAPIkey(key: String) {}

    func decodeAPIKey() -> String {
        "decodeAPIKey"
    }

    func deleteAPIKey(key: String) {}
}
