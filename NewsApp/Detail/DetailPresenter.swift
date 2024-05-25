//
//  DetailPresenter.swift
//  NewsApp
//
//  Created by Danil on 21.05.2024.
//

import Foundation

class DetailPresenter {
    
    weak var view: DetailViewController?
    let model: DetailModel
    weak var delegate: FavoritePresenterDelegate?
    
    init(view: DetailViewController, model: DetailModel ) {
        self.view = view
        self.model = model
    }
    
    func setData() {
        view?.authorLabel.text = model.author
        view?.descriptionLabel.text = model.description
        view?.sourceLabel.text = model.link
        view?.newsImage.loadImage(urlString: model.image ?? "")
    }
    
    func addToFavoritesStorage() {
        StorageManager.shared.saveToFavorites(author: model.author ?? "",
                                              descriptionNews: model.description ?? "",
                                              image: model.image ?? "",
                                              link: model.link ?? "",
                                              date: model.date ?? "") { [weak self] status in
            self?.view?.showAlert(title: status)
        }
    }
    
    func removeFromFavoriteStorage() {
        StorageManager.shared.deleteFromFavoritesNews(id: model.newsID!) { [weak self] status in
            self?.view?.showAlert(title: status)
            self?.delegate?.updateTable()
        }
    }
}
