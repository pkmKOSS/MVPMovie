// CacheServiceProtocol.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

protocol CacheServiceProtocol {
    /// Сохранение данных в кеш.
    /// - Parameters:
    ///   - fileURL: URL объекта. Используется для присвоения имени локальному файлу.
    ///   - data: Экземпляр Data
    ///   - cashDataType: Тип, который был источником Data. Влияет на директорию размещения файла.
    func saveDataToCache(fileURL: String, data: Data, cacheDataType: CacheDataType)

    /// Загрузка данных из кеша.
    /// - Parameters:
    ///   - fileURL: URL объекта. Используется для поиска файла.
    ///   - cashDataType: Тип, который был источником Data. Влияет на директорию размещения файла.
    ///   - completion: Возвращает экземпляр класса Result<Data, Swift.Error>).
    func loadDataFromCache(
        fileURL: String,
        cacheDataType: CacheDataType
    ) -> Data?
}
