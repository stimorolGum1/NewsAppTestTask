//
//  NewsViewController.swift
//  NewsApp
//
//  Created by Danil on 21.05.2024.
//

import UIKit

class NewsViewController: UIViewController {
    
    let tableCell = "newsCell"
    var presenter: NewsPresenter?
    
    lazy var newsTableView: UITableView = {
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
        presenter?.getData()
    }
    
    func setupViews() {
        view.addSubview(newsTableView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            newsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            newsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            newsTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            newsTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    func setupTableView() {
        newsTableView.delegate = self
        newsTableView.dataSource = self
        newsTableView.register(NewsCell.self, forCellReuseIdentifier: tableCell)
    }
    
    func reloadTable() {
        newsTableView.reloadData()
    }
    
}
extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfRowsInSection() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableCell, for: indexPath) as! NewsCell
        cell.newsImage.loadImage(urlString: presenter?.dataAtRow(index: indexPath.row).image_url ?? "")
        cell.authorLabel.text = presenter?.authorAtRow(index: indexPath.row)
        cell.dateLabel.text = presenter?.convertDate(index: indexPath.row)
        cell.discribeLabel.text = presenter?.descriptionAtRow(index: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = Builder().makeDetailScreen(popViewController: nil,
                                            isHide: false,
                                            data: DetailModel(newsID: nil,
                                                              date: presenter?.convertDate(index: indexPath.row),
                                                                             author: presenter?.authorAtRow(index: indexPath.row),
                                                              image: presenter?.dataAtRow(index: indexPath.row).image_url ?? "",
                                                              description: presenter?.descriptionAtRow(index: indexPath.row),
                                                              link: presenter?.dataAtRow(index: indexPath.row).link))
        present(detailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
            presenter?.getPaginationData(indexPath: indexPath)
    }
}
