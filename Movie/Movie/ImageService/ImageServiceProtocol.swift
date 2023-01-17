// ImageServiceProtocol.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Интерфейс загрузки фотографий.
protocol ImageServiceProtocol {
    /// Получить постер фильма.
    /// - Parameters:
    ///   - posterPath: адрес изображение. Получается как поле Result
    ///   - size: Размер изображения.
    ///   - complition: Замыкание.
    static func fetchImage(
        posterPath: String,
        size: SizeOfImages,
        complition: @escaping (GetImageResult) -> Void
    )
}
