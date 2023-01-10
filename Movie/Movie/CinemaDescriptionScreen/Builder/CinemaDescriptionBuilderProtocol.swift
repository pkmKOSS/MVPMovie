// CinemaDescriptionBuilderProtocol.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Интерфейс для создания экрана описания фильма.
protocol CinemaDescriptionBuilderProtocol {
    /// Создает viewController экрана описания фильма. Инжектит нужные зависимости
    /// - Parameters:
    ///   - cinemaDescription: Структура описывающая фильм.
    ///   - posterData: Data для преобразования в Image постера.
    /// - Returns: viewController экрана описания фильма со всеми зависимостями.
    func build(cinemaDescription: CinemaDescription, posterData: Data) -> CinemaDescriptionViewProtocol
}
