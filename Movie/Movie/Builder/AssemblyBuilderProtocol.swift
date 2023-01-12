// AssemblyBuilderProtocol.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол для сборщика экранов.
protocol AssemblyBuilderProtocol {
    /// Создает экран со списком фильмов. Инжектирует нужные зависимости
    /// - Parameters:
    ///   - router: Роутер экрана со списком фильмов
    /// - Returns: Экран со списком фильмов
    func makeCinemaListModule() -> UIViewController
    /// Создает экран с описанием фильмов. Инжектирует нужные зависимости
    /// - Parameters:
    ///   - router: Роутер экрана с описанием фильма.
    ///   - cinemaDescription: Структура с описанием фильма.
    ///   - posterData: Data изображения постера.
    /// - Returns: Экран с описанием фильма.
    func makeCinemaDescriptionModule(
        cinemaDescription: CinemaDescription,
        posterData: Data
    ) -> UIViewController
}
