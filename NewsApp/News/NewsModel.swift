//
//  NewsModel.swift
//  NewsApp
//
//  Created by Danil on 21.05.2024.
//

import Foundation

struct NewsResponse: Decodable {
    let status: String?
    let totalResults: Int?
    let results: [NewsArticle]?
    let nextPage: String?
}

struct NewsArticle: Decodable {
    let title: String?
    let link: String?
    let creator: [String]?
    let description: String?
    let pubDate: String?
    let image_url: String?
    let source_url: String
    let source_icon: String?
}

struct NewsModel {
    var items: [NewsArticle] = []
}
