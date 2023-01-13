// ImageService.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire
import Foundation

/// Загрузчик изображений.
final class ImageService: ImageServiceProtocol {
    // MARK: - Public methods

    static func fetchImage(
        posterPath: String,
        size: SizeOfImages,
        complition: @escaping (GetImageResult) -> Void
    ) {
        let urlString = "\(StringConstants.imageBaseUrl)\(size.rawValue)\(posterPath)"
        guard let url = URL(string: urlString) else { return }
        AF.request(url).response { response in
            guard
                let data = response.data
            else { return }
            let dataResult = GetImageResult.succes(cinema: data)
            complition(dataResult)
        }
    }
}
