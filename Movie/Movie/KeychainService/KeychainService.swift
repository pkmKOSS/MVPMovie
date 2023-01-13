// KeychainService.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Сервис для сохранения зашифрованной информации.
final class KeychainService {
    // MARK: - Public method

    static func updateAPI(key: String) {
        let query = [
            kSecClass: kSecClassGenericPassword,
        ] as CFDictionary

        let updateFields = [
            kSecValueData: key.data(using: .utf8)
        ] as CFDictionary

        SecItemUpdate(query, updateFields)
    }

    static func saveAPIkey(key: String) {
        let keyChainItemQuery = [
            kSecValueData: key.data(using: .utf8),
            kSecClass: kSecClassGenericPassword
        ] as CFDictionary

        SecItemAdd(keyChainItemQuery, nil)
    }

    static func decodeAPIKey() -> String {
        let keychainItem = [
            kSecClass: kSecClassGenericPassword,
            kSecReturnAttributes: true,
            kSecReturnData: true
        ] as CFDictionary

        var ref: AnyObject?

        SecItemCopyMatching(keychainItem, &ref)

        guard
            let result = ref as? NSDictionary,
            let passwordData = result[kSecValueData] as? Data
        else { return "" }
        return String(decoding: passwordData, as: UTF8.self)
    }
}
