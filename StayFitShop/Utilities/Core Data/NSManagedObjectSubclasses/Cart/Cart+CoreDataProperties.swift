//
//  Cart+CoreDataProperties.swift
//  StayFitShop
//
//  Created by Viktor Mauzer on 06.06.2022..
//
//

import Foundation
import CoreData


extension Cart {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Cart> {
        return NSFetchRequest<Cart>(entityName: "Cart")
    }

    @NSManaged public var products: NSSet?
    
    public var productsSet: [CachedProduct] {
        let set = products as? Set<CachedProduct> ?? []
        return set.sorted {
            $0.wrappedName < $1.wrappedName
        }
    }

}

// MARK: Generated accessors for products
extension Cart {

    @objc(addProductsObject:)
    @NSManaged public func addToProducts(_ value: CachedProduct)

    @objc(removeProductsObject:)
    @NSManaged public func removeFromProducts(_ value: CachedProduct)

    @objc(addProducts:)
    @NSManaged public func addToProducts(_ values: NSSet)

    @objc(removeProducts:)
    @NSManaged public func removeFromProducts(_ values: NSSet)

}

extension Cart : Identifiable {

}
