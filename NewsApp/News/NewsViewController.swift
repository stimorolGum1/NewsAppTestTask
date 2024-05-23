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
        newsTableView.delegate = self
        newsTableView.dataSource = self
        newsTableView.register(NewsCell.self, forCellReuseIdentifier: tableCell)
        setupViews()
        setupConstraints()
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
    
    func reloadTable() {
        newsTableView.reloadData()
    }
    
}
extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.prepareCountOfData() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableCell, for: indexPath) as! NewsCell
        cell.imageNews.loadImage(urlString: presenter?.prepareData(index: indexPath.row).image_url ?? "")
        cell.authorLabel.text = presenter?.prepareAuthor(index: indexPath.row)
        cell.dateLabel.text = presenter?.convertDate(index: indexPath.row)
        cell.discribeLabel.text = presenter?.prepareDescription(index: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = Builder().makeDetail(isHide: false, data: DetailModel(date: presenter?.convertDate(index: indexPath.row), author: presenter?.prepareAuthor(index: indexPath.row),
                                                              image: presenter?.prepareData(index: indexPath.row).image_url ?? "",
                                                              description: presenter?.prepareDescription(index: indexPath.row),
                                                              link: presenter?.prepareData(index: indexPath.row).link))
        self.present(detailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
            presenter?.getPaginationData(indexPath: indexPath)
    }
}
