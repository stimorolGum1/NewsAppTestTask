//
//  FavoriteViewController.swift
//  NewsApp
//
//  Created by Danil on 21.05.2024.
//

import UIKit


class FavoriteViewController: UIViewController {
    
    let tableCell = "favoriteCell"
    var presenter: FavoritePresenter?
    
    lazy var favoriteTableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        setupConstraints()
        setupTableView()
        presenter?.fetchDataFromFavoritesStorage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter?.fetchDataFromFavoritesStorage()
    }
    
    func setupViews() {
        view.addSubview(favoriteTableView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            favoriteTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            favoriteTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            favoriteTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            favoriteTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    func setupTableView() {
        favoriteTableView.delegate = self
        favoriteTableView.dataSource = self
        favoriteTableView.register(FavoriteCell.self, forCellReuseIdentifier: tableCell)
    }
    
    func reloadTable() {
        favoriteTableView.reloadData()
    }
}

extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfRowsInSection() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableCell, for: indexPath) as! FavoriteCell
        cell.newsImage.loadImage(urlString: presenter?.dataAtRow(index: indexPath.row).image ?? "")
        cell.authorLabel.text = presenter?.authorAtRow(index: indexPath.row)
        cell.dateLabel.text = presenter?.dataAtRow(index: indexPath.row).date
        cell.discribeLabel.text = presenter?.descriptionAtRow(index: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = Builder().makeDetailScreen(popViewController: presenter,
                                            isHide: true,
                                            data: DetailModel(newsID: presenter?.dataAtRow(index: indexPath.row).objectID,
                                                                            date: presenter?.dataAtRow(index: indexPath.row).date,
                                                                            author: presenter?.authorAtRow(index: indexPath.row),
                                                              image: presenter?.dataAtRow(index: indexPath.row).image ?? "",
                                                              description: presenter?.descriptionAtRow(index: indexPath.row),
                                                              link: presenter?.dataAtRow(index: indexPath.row).link))
        present(detailVC, animated: true)
    }
}
