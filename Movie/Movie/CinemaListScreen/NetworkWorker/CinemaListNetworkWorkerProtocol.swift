// CinemaListNetworkWorkerProtocol.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

protocol CinemaListNetworkWorkerProtocol: AnyObject {
    func fetchCinema(completion: @escaping (CinemaInfoProtocol) -> ())
    func getImage(
        posterPath: String,
        size: SizeOfImages,
        completion: @escaping (Data) -> ()
    )
}
