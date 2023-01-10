// CinemaListScreenBuilderProtocol.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Интерфейс билдера экрана со списком фильмов.
protocol CinemaListScreenBuilderProtocol {
    /// Создает экран со списком фильмов. Инжектирует нужные зависимости
    /// - Returns: <#description#>
    func build() -> CinemaListViewController
}
