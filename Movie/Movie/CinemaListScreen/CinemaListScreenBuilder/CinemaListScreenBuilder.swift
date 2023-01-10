// CinemaListScreenBuilder.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class CinemaListScreenBuilder: CinemaListScreenBuilderProtocol {
    func build() -> CinemaListViewController {
        let presenter = CinemaListScreenPresenter()
        let worker = CinemaListNetworkWorker()
        let viewController = CinemaListViewController()
        viewController.presenter = presenter
        presenter.worker = worker
        presenter.viewController = viewController
        return viewController
    }
}
