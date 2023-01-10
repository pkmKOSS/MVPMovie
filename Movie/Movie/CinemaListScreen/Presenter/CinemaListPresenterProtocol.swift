// CinemaListPresenterProtocol.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Интерфейс презентера экрана со списком фильмов.
protocol CinemaListPresenterProtocol: AnyObject {
    /// Получение фильмов.
    /// - Parameter typeOfCinema: тип  фильмов, которые нужно получить.
    func fetchCinema(typeOfCinema: TypeOfCinema)
    /// Показать полученные фильмы.
    /// - Parameter cinema: список полученных фильмов с описанием.
    func presentCinema(cinema: CinemaInfoProtocol)
    /// Получить изображение-постер фильма.
    /// - Parameters:
    ///   - posterPath: адрес изображения.
    ///   - size: размер изображения.
    func fetchImage(
        posterPath: String,
        size: SizeOfImages
    )
    /// Навигация на экран с описанием фильма.
    /// - Parameters:
    ///   - cinemaDescription: описание фильма
    ///   - posterData: Data для преобразования в UIImage постера.
    ///   - rootViewController: viewController с которого осуществляется навигация.
    func routToDescription(
        cinemaDescription: CinemaDescription,
        posterData: Data,
        rootViewController: CinemaListViewProtocol
    )
}
