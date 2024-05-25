//
//  NetworkManager.swift
//  NewsApp
//
//  Created by Danil on 21.05.2024.
//

import Foundation

class NetworkManager {
    let token = "pub_447496f5e6470434a953b26548ed7e1826ad8"
    
    func fetchData(completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: "https://newsdata.io/api/1/latest?apikey=\(token)") else { return }
        URLSession.shared.dataTask(with: url) {data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
                }
                if let data = data {
                    completion(.success(data))
                }
            }
        }.resume()
    }
    
    func fetchPaginationData(page: String,completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: "https://newsdata.io/api/1/latest?apikey=\(token)&page=\(page)") else { return }
        URLSession.shared.dataTask(with: url) {data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
                }
                if let data = data {
                    completion(.success(data))
                }
            }
        }.resume()
    }
}

