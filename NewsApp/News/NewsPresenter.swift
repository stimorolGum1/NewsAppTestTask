//
//  NewsPresenter.swift
//  NewsApp
//
//  Created by Danil on 21.05.2024.
//

import Foundation

class NewsPresenter {
    
    weak var view: NewsViewController?
    let networkManager: NetworkManager
    var model: NewsModel
    let jsonDecoder = JSONDecoder()
    var nextPage: String = ""
    
    init(view: NewsViewController, networkManager: NetworkManager, model: NewsModel) {
        self.view = view
        self.networkManager = networkManager
        self.model = model
    }
    
    func numberOfRowsInSection() -> Int {
        return model.items.count
    }
    
    func dataAtRow(index: Int) -> NewsArticle {
        return self.model.items[index]
    }
    
    func authorAtRow(index: Int) -> String {
        guard let creator = self.model.items[index].creator,
              let firstCreator = creator.first,
              !firstCreator.isEmpty else {
            return "No author"
        }
        return firstCreator
    }
    
    func descriptionAtRow(index: Int) -> String {
        guard let description = self.model.items[index].description else {
            return "No Description"
        }
        return description
    }
    
    func convertDate(index: Int) -> String {
        let date = self.model.items[index].pubDate ?? ""
        let sourceDateFormat = "yyyy-MM-dd HH:mm:ss"
        let neededFormat = "dd.MM.yy HH:mm"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = sourceDateFormat
        if let date = dateFormatter.date(from: date) {
            dateFormatter.dateFormat = neededFormat
            return dateFormatter.string(from: date)
        } else {
            return "No Date"
        }
    }
    
    func getData() {
        networkManager.fetchData() { [weak self] result in
            switch result {
            case .success(let data):
                do {
                    let jsonData = try self?.jsonDecoder.decode(NewsResponse.self, from: data)
                    self?.model.items = jsonData?.results ?? []
                    self?.nextPage = jsonData?.nextPage ?? ""
                    self?.view?.reloadTable()
                } catch {
                    fatalError()
                }
            case .failure(let error):
                fatalError(error.localizedDescription)
            }
        }
    }
    
    func getPaginationData(indexPath: IndexPath) {
        if indexPath.row == model.items.count - 1 {
            networkManager.fetchPaginationData(page: nextPage) { [weak self] result in
                switch result {
                case .success(let data):
                    do {
                        let jsonData = try self?.jsonDecoder.decode(NewsResponse.self, from: data)
                        self?.model.items.append(contentsOf: jsonData?.results ?? [])
                        self?.nextPage = jsonData?.nextPage ?? ""
                        self?.view?.reloadTable()
                    } catch {
                        fatalError()
                    }
                case .failure(let error):
                    fatalError(error.localizedDescription)
                }
            }
        }
    }
}
