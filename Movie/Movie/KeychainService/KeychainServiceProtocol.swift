// KeychainServiceProtocol.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Интерфейс для работы с зашифрованной информацией.
protocol KeychainServiceProtocol: AnyObject {
    func updateAPI(key: String)
    func saveAPIkey(key: String)
    func decodeAPIKey() -> String
    func deleteAPIKey(key: String)
}
