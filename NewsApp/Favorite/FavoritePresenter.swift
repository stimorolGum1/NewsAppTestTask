//
//  FavoritePresenter.swift
//  NewsApp
//
//  Created by Danil on 21.05.2024.
//

import Foundation

class FavoritePresenter {
    
    weak var view: FavoriteViewController?
    var model: FavoriteNewsModel
    
    init(view: FavoriteViewController, model: FavoriteNewsModel) {
        self.view = view
        self.model = model
    }
    
    func prepareCountOfData() -> Int {
        return model.items.count
    }
    
    func prepareData(index: Int) -> Favorites {
        return self.model.items[index]
    }
    
    func prepareAuthor(index: Int) -> String {
        guard let creator = self.model.items[index].author else {
            return "No author"
        }
        return creator
    }
    
    func prepareDescription(index: Int) -> String {
        guard let description = self.model.items[index].descriptionNews else {
            return "No Description"
        }
        return description
    }
    
    func fetchDataFromFavorites() {
        StorageManager.shared.fetchFiles { [weak self] fetchedData in
                    if let fetchedData = fetchedData {
                        self?.model.items = fetchedData
                        self?.view?.reloadTable()
                    } else {
                        fatalError()
                    }
                }
    }
}
