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
    
    init(view: DetailViewController, model: DetailModel) {
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
        StorageManager.shared.saveToFavorites(author: model.author ?? "", descriptionNews: model.description ?? "", image: model.image ?? "", link: model.link ?? "", date: model.date ?? "")
    }
    
    func removeFromFavorite() {
        StorageManager.shared.deleteFromFavorites(link: model.link ?? "")
    }
}
