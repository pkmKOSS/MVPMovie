// DataRepositoryProtocol.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Интерфейс репозитория для работы с сетью экрана со списком фильмов.
protocol DataRepositoryProtocol: AnyObject {
    /// Загрузить список фильмов и их описание.
    /// - Parameters:
    ///   - typeOfCinema: тип фильмов.
    ///   - completion: блок с информацией о фильмах.
    func fetchCinema(typeOfCinema: TypeOfCinema, completion: @escaping (CinemaInfoProtocol) -> ())
    /// Загрузить изображение-постер.
    /// - Parameters:
    ///   - posterPath: Адрес изображения.
    ///   - size: Размер изображения.
    ///   - completion: Блок с Data изображения.
    func fetchImage(
        posterPath: String,
        size: SizeOfImages,
        completion: @escaping (Data) -> ()
    )
}
