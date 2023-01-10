// CinemaListViewProtocol.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Интерфейс представления экрана со списком фильмов.
protocol CinemaListViewProtocol: AnyObject {
    /// Показывает загруженный фильм.
    /// - Parameter cinema: описание фильма.
    func showCinema(cinema: CinemaInfoProtocol)
    /// Показывает загруженный постер фильма.
    /// - Parameters:
    ///   - imageData: Data для преобразования  в UIImage постера.
    ///   - posterPath: Путь к изображению. Используется как ключ для поиска нужного изображения в словаре.
    func showCinemaPoster(imageData: Data, posterPath: String)
}
