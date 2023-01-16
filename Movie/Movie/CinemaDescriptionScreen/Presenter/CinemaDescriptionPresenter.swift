// CinemaDescriptionPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Презентер экрана с подробностями о фильме.
final class CinemaDescriptionPresenter: CinemaDescriptionPresenterProtocol {
    // MARK: Public properties

    weak var view: CinemaDescriptionViewProtocol!
    weak var router: CinemaDescriptionRouterProtocol?

    init(router: CinemaDescriptionRouterProtocol) {
        self.router = router
    }

    func sayHellow() {
        view?.sayHellow()
    }
}
