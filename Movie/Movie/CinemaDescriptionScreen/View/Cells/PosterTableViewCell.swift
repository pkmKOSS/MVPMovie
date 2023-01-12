// PosterTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка с паспортом.
final class PosterTableViewCell: UITableViewCell {
    // MARK: - Private visual components

    private var posterImageView = UIImageView()

    // MARK: - Public methods

    func configureCell(imageData: Data) {
        configurePosterImageView(posterImage: UIImage(data: imageData) ?? UIImage())
        makePosterImageViewLayout()
        configureContentView()
    }

    // MARK: - Private methods

    private func configurePosterImageView(posterImage: UIImage) {
        addSubview(posterImageView)
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        posterImageView.image = posterImage
        posterImageView.contentMode = .scaleAspectFill
    }

    private func makePosterImageViewLayout() {
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: topAnchor),
            posterImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            posterImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            posterImageView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

    private func configureContentView() {
        selectionStyle = .none
    }
}
