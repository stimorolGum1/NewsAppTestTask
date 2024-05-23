//
//  Builder.swift
//  NewsApp
//
//  Created by Danil on 21.05.2024.
//

import Foundation
import UIKit

class Builder {
    func makeDetail(isHide: Bool, data: DetailModel ) -> UIViewController {
        let model = DetailModel(date: data.date, author: data.author, image: data.image, description: data.description, link: data.link)
        let view = DetailViewController()
        let presenter = DetailPresenter(view: view, model: model)
        view.isfavoriteButtonHide = isHide
        view.presenter = presenter
        return view
    }
    
    func makeNews() -> UIViewController {
        let model = NewsModel()
        let view = NewsViewController()
        let networkManager = NetworkManager()
        let presenter = NewsPresenter(view: view, networkManager: networkManager, model: model)
        view.presenter = presenter
        view.title = "Новости"
        return view
    }
    
    func makeFavorite() -> UIViewController {
        let model = FavoriteNewsModel()
        let view = FavoriteViewController()
        let presenter = FavoritePresenter(view: view, model: model)
        view.presenter = presenter
        view.title = "Избранное"
        return view
    }
}
