//
//  DetailModel.swift
//  NewsApp
//
//  Created by Danil on 21.05.2024.
//

import Foundation
import CoreData

struct DetailModel {
    let newsID: NSManagedObjectID?
    let date: String?
    let author: String?
    let image: String?
    let description: String?
    let link: String?
}

