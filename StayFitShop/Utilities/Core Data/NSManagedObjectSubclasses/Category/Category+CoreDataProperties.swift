//
//  Category+CoreDataProperties.swift
//  StayFitShop
//
//  Created by Viktor Mauzer on 02.06.2022..
//
//

import Foundation
import CoreData


extension Category {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category")
    }

    @NSManaged public var name: String?
    @NSManaged public var product: CachedProduct?
    
    var wrappedName: String {
        name ?? "Unknown Category"
    }

}

extension Category : Identifiable {

}
