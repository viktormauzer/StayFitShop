//
//  ImageGallery+CoreDataProperties.swift
//  StayFitShop
//
//  Created by Viktor Mauzer on 02.06.2022..
//
//

import Foundation
import CoreData


extension ImageGallery {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ImageGallery> {
        return NSFetchRequest<ImageGallery>(entityName: "ImageGallery")
    }

    @NSManaged public var image: String?
    @NSManaged public var product: CachedProduct?
    
    var wrappedImage: String {
        image ?? "DefaultProductImage"
    }

}

extension ImageGallery : Identifiable {

}
