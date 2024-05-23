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
        favoriteTableView.delegate = self
        favoriteTableView.dataSource = self
        favoriteTableView.register(FavoriteCell.self, forCellReuseIdentifier: tableCell)
        setupViews()
        setupConstraints()
        presenter?.fetchDataFromFavorites()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter?.fetchDataFromFavorites()
        reloadTable()
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
    func reloadTable() {
        favoriteTableView.reloadData()
    }
}

extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.prepareCountOfData() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableCell, for: indexPath) as! FavoriteCell
        cell.imageNews.loadImage(urlString: presenter?.prepareData(index: indexPath.row).image ?? "")
        cell.authorLabel.text = presenter?.prepareAuthor(index: indexPath.row)
        cell.dateLabel.text = presenter?.prepareData(index: indexPath.row).date
        cell.discribeLabel.text = presenter?.prepareDescription(index: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = Builder().makeDetail(isHide: true, data: DetailModel(date: presenter?.prepareData(index: indexPath.row).date,
                                                                            author: presenter?.prepareAuthor(index: indexPath.row),
                                                              image: presenter?.prepareData(index: indexPath.row).image ?? "",
                                                              description: presenter?.prepareDescription(index: indexPath.row),
                                                              link: presenter?.prepareData(index: indexPath.row).link))
        self.present(detailVC, animated: true)
    }
}
