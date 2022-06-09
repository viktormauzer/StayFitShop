//
//  Size+CoreDataProperties.swift
//  StayFitShop
//
//  Created by Viktor Mauzer on 02.06.2022..
//
//

import Foundation
import CoreData


extension Size {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Size> {
        return NSFetchRequest<Size>(entityName: "Size")
    }

    @NSManaged public var size: Int16
    @NSManaged public var product: CachedProduct?

}

extension Size : Identifiable {

}
