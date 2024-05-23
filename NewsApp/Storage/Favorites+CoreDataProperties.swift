//
//  Favorites+CoreDataProperties.swift
//  NewsApp
//
//  Created by Danil on 23.05.2024.
//
//

import Foundation
import CoreData

public class Favorites: NSManagedObject {

}

extension Favorites {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Favorites> {
        return NSFetchRequest<Favorites>(entityName: "Favorites")
    }

    @NSManaged public var link: String?
    @NSManaged public var descriptionNews: String?
    @NSManaged public var image: String?
    @NSManaged public var date: String?
    @NSManaged public var author: String?

}

extension Favorites : Identifiable {

}
