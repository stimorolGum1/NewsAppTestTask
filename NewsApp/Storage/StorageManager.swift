//
//  StorageManager.swift
//  NewsApp
//
//  Created by Danil on 23.05.2024.
//

import Foundation
import CoreData

class StorageManager {
    
    static let shared = StorageManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Favorites")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    init() {
    }
    
    func saveToFavorites(author: String,
                         descriptionNews: String,
                         image: String,
                         link: String,
                         date: String, completion: @escaping (String) -> Void) {
        let file = Favorites(context: context)
        file.author = author
        file.descriptionNews = descriptionNews
        file.image = image
        file.link = link
        file.date = date
        if context.hasChanges {
            do {
                try context.save()
                completion("Успешно добавлено в избранное")
            } catch {
                context.rollback()
            }
        }
    }
    
    func deleteFromFavoritesNews(id: NSManagedObjectID, completion: @escaping (String) -> Void) {
        do {
            let object = try context.existingObject(with: id)
            context.delete(object)
            if context.hasChanges {
                try context.save()
                completion("Успешно удалено из избранного")
            }
        } catch {
            context.rollback()
        }
    }
    
    func fetchFavoritesNews(completion: @escaping ([Favorites]?) -> Void) {
        let fetchRequest: NSFetchRequest<Favorites> = Favorites.fetchRequest()
        do {
            let fetchedData = try context.fetch(fetchRequest)
            completion(fetchedData)
        } catch {
            completion(nil)
        }
    }
}
