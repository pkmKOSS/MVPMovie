// CinemaListRouterProtocol.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Интерфейс навигации на экран описания фильма.
protocol CinemaListRouterProtocol: AnyObject {
    /// Навигация на экран описания фильма.
    /// - Parameters:
    ///   - description: структура с описанием фильма.
    ///   - imageData: Data для преобразования  в UIImage постера
    ///   - rootViewController: контроллер с которого осуществляется навигация.
    func routTo(description: CinemaDescription, imageData: Data, rootViewController: CinemaListViewProtocol)
}
