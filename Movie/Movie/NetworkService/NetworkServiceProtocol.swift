// NetworkServiceProtocol.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Интерфейс загрузки фильмов.
protocol NetworkServiceProtocol {
    /// Запросить список кинофильмов.
    /// - Parameters:
    ///   - typeOfRequest: Тип запроса в зависимости от конкретных характеристик кинофильмов.
    ///   - handler: Возвращает массив кинофильмов или ошибку.
    func fetchCinema(typeOfRequest: TypeOfCinemaRequset, completion: @escaping (GetPostResult) -> Void)

    func sendRequest<T: JSONCodable>(
        urlString: String,
        model: T.Type,
        completion: @escaping (GetPostResult) -> Void
    )
}
