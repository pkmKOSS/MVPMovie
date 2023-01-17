// DataBaseServiceProtocol.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import Realm
import RealmSwift

/// Интерфейс для работы с локальными данными.
protocol DataBaseServiceProtocol {
    func saveData<T: Object>(objects: [T])

    func loadData<T: Object>(objectType: T.Type) -> [T]?
}
