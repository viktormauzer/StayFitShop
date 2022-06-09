//
//  CachedProduct+CoreDataProperties.swift
//  StayFitShop
//
//  Created by Viktor Mauzer on 02.06.2022..
//
//

import Foundation
import CoreData


extension CachedProduct {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedProduct> {
        return NSFetchRequest<CachedProduct>(entityName: "CachedProduct")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var desc: String?
    @NSManaged public var image: String?
    @NSManaged public var price: Double
    @NSManaged public var stock: Int16
    @NSManaged public var isFavorite: Bool
    @NSManaged public var quantity: Double
    @NSManaged public var selectedSize: Int16
    @NSManaged public var selectedQuantity: Double
    @NSManaged public var category: NSSet?
    @NSManaged public var size: NSSet?
    @NSManaged public var imageGallery: NSSet?
    @NSManaged public var cart: NSSet?
    
    var wrappedName: String {
        name ?? "Unknown Name"
    }
    
    var wrappedDescription: String {
        desc ?? "Unknown Description"
    }
    
    var wrappedImage: String {
        image ?? "DefaultProductImage"
    }
    
    public var categories: [Category] {
        let set = category as? Set<Category> ?? []
        return set.sorted {
            $0.wrappedName < $1.wrappedName
        }
    }
    
    public var sizes: [Size] {
        let set = size as? Set<Size> ?? []
        return set.sorted {
            $0.size < $1.size
        }
    }
    
    public var imageGallerySet: [ImageGallery] {
        let set = imageGallery as? Set<ImageGallery> ?? []
        return set.sorted {
            $0.wrappedImage > $1.wrappedImage
        }
    }
    
    var categoriesArray: [String] {
        var preparedCategories = [String]()
        for category in categories {
            preparedCategories.append(category.wrappedName)
        }
        return preparedCategories
    }
    
    var sizesArray: [Int]? {
        var preparedSizes = [Int]()
        for size in sizes {
            preparedSizes.append(Int(size.size))
        }
        
        if preparedSizes.isEmpty {
            return nil
        } else {
            return preparedSizes
        }
    }
    
    var imageGalleryArray: [String] {
        var preparedImageGallery = [String]()
        for imageGalleryImage in imageGallerySet {
            preparedImageGallery.append(imageGalleryImage.wrappedImage)
        }
        
        return preparedImageGallery
    }

}

// MARK: Generated accessors for category
extension CachedProduct {

    @objc(addCategoryObject:)
    @NSManaged public func addToCategory(_ value: Category)

    @objc(removeCategoryObject:)
    @NSManaged public func removeFromCategory(_ value: Category)

    @objc(addCategory:)
    @NSManaged public func addToCategory(_ values: NSSet)

    @objc(removeCategory:)
    @NSManaged public func removeFromCategory(_ values: NSSet)

}

// MARK: Generated accessors for size
extension CachedProduct {

    @objc(addSizeObject:)
    @NSManaged public func addToSize(_ value: Size)

    @objc(removeSizeObject:)
    @NSManaged public func removeFromSize(_ value: Size)

    @objc(addSize:)
    @NSManaged public func addToSize(_ values: NSSet)

    @objc(removeSize:)
    @NSManaged public func removeFromSize(_ values: NSSet)

}

// MARK: Generated accessors for imageGallery
extension CachedProduct {

    @objc(addImageGalleryObject:)
    @NSManaged public func addToImageGallery(_ value: ImageGallery)

    @objc(removeImageGalleryObject:)
    @NSManaged public func removeFromImageGallery(_ value: ImageGallery)

    @objc(addImageGallery:)
    @NSManaged public func addToImageGallery(_ values: NSSet)

    @objc(removeImageGallery:)
    @NSManaged public func removeFromImageGallery(_ values: NSSet)

}

// MARK: Generated accessors for cart
extension CachedProduct {

    @objc(addCartObject:)
    @NSManaged public func addToCart(_ value: Cart)

    @objc(removeCartObject:)
    @NSManaged public func removeFromCart(_ value: Cart)

    @objc(addCart:)
    @NSManaged public func addToCart(_ values: NSSet)

    @objc(removeCart:)
    @NSManaged public func removeFromCart(_ values: NSSet)

}

extension CachedProduct : Identifiable {

}
