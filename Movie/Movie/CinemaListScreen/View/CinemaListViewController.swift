// CinemaListViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран со списком кинофильмов.
final class CinemaListViewController: UIViewController, CinemaListViewProtocol {
    // MARK: - Private types

    enum CellIdentifiers: String {
        case cinemaListIdentifier = "CinemaListCell"
    }

    // MARK: - Public properties

    var presenter: CinemaListPresenterProtocol?

    // MARK: - Private properties

    private let condition = NSCondition()
    private var cinemaDescriptions: [CinemaDescription] = []
    private var imageDataMap: [String: Data] = [:]
    private var cinemaArray: CinemaInfoProtocol?
    private var actionHandler: TapAction?

    // MARK: - Private visual components

    private var cinemaListTableView = UITableView()
    private var showUpcomingCinemaButton = UIButton()
    private var showPopularCinemaButton = UIButton()
    private var showNewCinemaButton = UIButton()

    // MARK: - life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        fetchCinema()
    }

    func showCinemaPoster(imageData: Data, posterPath: String) {
        imageDataMap[posterPath] = imageData
        DispatchQueue.main.async {
            let numberOfRow = self.cinemaDescriptions.firstIndex { cinema in
                guard cinema.posterPath == posterPath else { return false }
                return true
            }

            let indexPath = IndexPath(row: numberOfRow ?? 0, section: 0)
            self.cinemaListTableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }

    func showCinema(cinema: CinemaInfoProtocol) {
        cinema.results.forEach { [weak self] result in
            guard let self = self else { return }
            self.getImage(posterPath: result.posterPath, size: .w500)
            cinemaDescriptions.append(CinemaDescription(
                title: result.title,
                modelOverview: result.overview,
                modelVoteAverage: result.voteAverage,
                modelVoteCount: result.voteCount,
                posterPath: result.posterPath
            ))
        }

        DispatchQueue.main.async {
            self.cinemaListTableView.reloadData()
        }
    }

    // MARK: - private methods

    private func addSubviews() {
        view.addSubview(cinemaListTableView)
        view.addSubview(showUpcomingCinemaButton)
        view.addSubview(showPopularCinemaButton)
        view.addSubview(showNewCinemaButton)
        configureTapAction()
        configureViews()
    }

    private func configureViews() {
        view.backgroundColor = .white
        configureCinemaListTableView()
        configureShowUpcomingCinema()
        configureShowPopularCinemaButton()
        configureShowNewCinema()
        makeLayout()
    }

    private func makeLayout() {
        makeCinemaListTableViewLayout()
        makeShowUpcomingCinemaLayout()
        makeShowPopularCinemaButtonLayout()
        makeShowNewCinemaLayout()
    }

    private func configureCinemaListTableView() {
        cinemaListTableView.separatorColor = .white
        cinemaListTableView.dataSource = self
        cinemaListTableView.delegate = self
        cinemaListTableView.translatesAutoresizingMaskIntoConstraints = false

        cinemaListTableView.register(
            CinemaListTableViewCell.self,
            forCellReuseIdentifier: CellIdentifiers.cinemaListIdentifier.rawValue
        )
    }

    private func makeCinemaListTableViewLayout() {
        NSLayoutConstraint.activate([
            cinemaListTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            cinemaListTableView.topAnchor.constraint(equalTo: showUpcomingCinemaButton.bottomAnchor, constant: 10),
            cinemaListTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            cinemaListTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    private func configureShowUpcomingCinema() {
        showUpcomingCinemaButton.translatesAutoresizingMaskIntoConstraints = false
        showUpcomingCinemaButton.setTitle(StringConstants.showUpcomingCinemaTitle, for: .normal)
        showUpcomingCinemaButton.backgroundColor = .systemYellow
        showUpcomingCinemaButton.layer.cornerRadius = 5
        showUpcomingCinemaButton.clipsToBounds = true
        showUpcomingCinemaButton.addTarget(self, action: #selector(getUpcomingCinemaAction), for: .touchUpInside)
    }

    private func makeShowUpcomingCinemaLayout() {
        NSLayoutConstraint.activate([
            showUpcomingCinemaButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            showUpcomingCinemaButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            showUpcomingCinemaButton.widthAnchor.constraint(equalToConstant: view.frame.width / 3)
        ])
    }

    private func configureShowPopularCinemaButton() {
        showPopularCinemaButton.translatesAutoresizingMaskIntoConstraints = false
        showPopularCinemaButton.setTitle(StringConstants.showPopularCinemaTitle, for: .normal)
        showPopularCinemaButton.backgroundColor = .systemYellow
        showPopularCinemaButton.layer.cornerRadius = 5
        showPopularCinemaButton.clipsToBounds = true
        showPopularCinemaButton.addTarget(self, action: #selector(getPopularCinemaAction), for: .touchUpInside)
    }

    private func makeShowPopularCinemaButtonLayout() {
        NSLayoutConstraint.activate([
            showPopularCinemaButton.leadingAnchor.constraint(
                equalTo: showUpcomingCinemaButton.trailingAnchor,
                constant: +5
            ),
            showPopularCinemaButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: +5),
            showPopularCinemaButton.widthAnchor.constraint(equalToConstant: view.frame.width / 3.1)
        ])
    }

    private func configureShowNewCinema() {
        NSLayoutConstraint.activate([
            showNewCinemaButton.leadingAnchor.constraint(equalTo: showPopularCinemaButton.trailingAnchor, constant: +5),
            showNewCinemaButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: +5),
            showNewCinemaButton.widthAnchor.constraint(equalToConstant: view.frame.width / 3.1)
        ])
    }

    private func makeShowNewCinemaLayout() {
        showNewCinemaButton.translatesAutoresizingMaskIntoConstraints = false
        showNewCinemaButton.setTitle(StringConstants.showNewCinemaTitle, for: .normal)
        showNewCinemaButton.backgroundColor = .systemYellow
        showNewCinemaButton.layer.cornerRadius = 5
        showNewCinemaButton.clipsToBounds = true
    }

    private func fetchCinema() {
        presenter?.fetchCinema(typeOfCinema: .upcomingCinema)
    }

    private func configureTapAction() {
        actionHandler = { [weak self] helper, image in
            guard let self = self else { return }
            self.presenter?.routToDescription(cinemaDescription: helper, posterData: image, rootViewController: self)
        }
    }

    private func getImage(
        posterPath: String,
        size: SizeOfImages
    ) {
        presenter?.fetchImage(posterPath: posterPath, size: size)
    }

    // MARK: - @objc private methods

    @objc private func getUpcomingCinemaAction() {
        presenter?.fetchCinema(typeOfCinema: .upcomingCinema)
    }

    @objc private func getPopularCinemaAction() {
        presenter?.fetchCinema(typeOfCinema: .popularCinema)
    }

    @objc private func getNewCinemaAction() {
        presenter?.fetchCinema(typeOfCinema: .newCinema)
    }
}

// Имплементация UITableViewDelegate, UITableViewDataSource
extension CinemaListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cinemaDescriptions.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView
            .dequeueReusableCell(
                withIdentifier: CellIdentifiers.cinemaListIdentifier.rawValue,
                for: indexPath
            ) as? CinemaListTableViewCell
        else { return UITableViewCell() }

        cell.configure(
            description: cinemaDescriptions[indexPath.row],
            handler: actionHandler,
            imageData: imageDataMap[cinemaDescriptions[indexPath.row].posterPath]
        )

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}