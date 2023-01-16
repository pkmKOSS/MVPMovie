// ImageServiceTests.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire
@testable import Movie
import XCTest

/// Тесты сервиса загрузки изображения
final class ImageServiceTests: XCTestCase {
    // MARK: - private properties

    private var imageService: ImageServiceProtocol!

    // MARK: - public methods

    override func setUpWithError() throws {
        imageService = ImageService()
    }

    override func tearDownWithError() throws {}

    func testFetchImage() {
        imageService.fetchImage(posterPath: "/yDtgeQ2bwALLw1G2345XVeeP3wX.jpg", size: .w500) { result in
            var imageData: Data?
            var responseError: Error?
            switch result {
            case let .succes(data):
                imageData = data
            default:
                break
            }
            XCTAssertNotNil(imageData)
            XCTAssertNil(responseError)
        }
    }
}
