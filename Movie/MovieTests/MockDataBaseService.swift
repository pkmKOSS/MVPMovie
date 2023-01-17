// MockDataBaseService.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
@testable import Movie
import RealmSwift

/// Мок сервиса работы с данными.
final class MockDataBaseService: DataBaseServiceProtocol {
    // MARK: - public methpds

    func saveData<T: Object>(objects: [T]) {}

    func loadData<T: Object>(objectType: T.Type) -> [T]? { [] }
}
