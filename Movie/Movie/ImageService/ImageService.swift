// ImageService.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire
import Foundation

/// Загрузчик изображений.
final class ImageService: ImageServiceProtocol {
    // MARK: - Public methods

    func fetchImage(
        posterPath: String,
        size: SizeOfImages,
        completion: @escaping (GetImageResult) -> Void
    ) {
        let urlString = "\(StringConstants.imageBaseUrl)\(size.rawValue)\(posterPath)"
        guard let url = URL(string: urlString) else { return }

        AF.request(url).response { response in
            guard
                let data = response.data
            else {
                guard let error = response.error else { return }
                completion(GetImageResult.failure(cinema: error))
                return
            }

            let dataResult = GetImageResult.succes(cinema: data)

            completion(dataResult)
        }
    }
}
