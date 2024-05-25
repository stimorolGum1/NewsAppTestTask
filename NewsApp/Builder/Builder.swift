//
//  Builder.swift
//  NewsApp
//
//  Created by Danil on 21.05.2024.
//

import Foundation
import UIKit

class Builder {
    func makeDetailScreen(popViewController: FavoritePresenterDelegate?, isHide: Bool, data: DetailModel) -> UIViewController {
        let model = DetailModel(newsID: data.newsID,
                                date: data.date,
                                author: data.author,
                                image: data.image,
                                description: data.description,
                                link: data.link)
        let view = DetailViewController()
        let presenter = DetailPresenter(view: view,
                                        model: model)
        view.isfavoriteButtonHide = isHide
        view.presenter = presenter
        presenter.delegate = popViewController
        return view
    }
    
    func makeNewsScreen() -> UIViewController {
        let model = NewsModel()
        let view = NewsViewController()
        let networkManager = NetworkManager()
        let presenter = NewsPresenter(view: view,
                                      networkManager: networkManager,
                                      model: model)
        view.presenter = presenter
        view.title = "Новости"
        return view
    }
    
    func makeFavoriteScreen() -> UIViewController {
        let model = FavoriteNewsModel()
        let view = FavoriteViewController()
        let presenter = FavoritePresenter(view: view,
                                          model: model)
        view.presenter = presenter
        view.title = "Избранное"
        return view
    }
}
