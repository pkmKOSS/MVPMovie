// MockDataBaseService.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
@testable import Movie
import Realm
import RealmSwift

/// Мок сервиса работы с данными.
final class MockDataBaseService: DataBaseServiceProtocol {

    // MARK: - public methpds
    
    func saveData<T>(objects: [T]) where T: RealmSwiftObject {}

    func loadData<T>(objectType: T.Type) -> [T]? where T: RealmSwiftObject {
        []
    }
}
