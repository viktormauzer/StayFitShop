//
//  CoreDataManager.swift
//  StayFitShop
//
//  Created by Viktor Mauzer on 02.06.2022..
//

import Foundation
import SwiftUI
import CoreData

@MainActor final class CoreDataManager {
    static let shared = CoreDataManager()
    private init() {}
    
    let networkManager = NetworkManager()
    var products: [Product] = []
    var cart: [Product] = []
    
    func getCachedProductsReady(_ cachedProducts: FetchedResults<CachedProduct>, _ moc: NSManagedObjectContext) async throws {
        if cachedProducts.isEmpty {
            do {
                if let fetchedProducts = try await networkManager.getProducts() {
                    products = fetchedProducts
                }
                
                for product in products {
                    let newProduct = CachedProduct(context: moc)
                    newProduct.id = product.id
                    newProduct.name = product.name
                    newProduct.desc = product.description
                    newProduct.price = product.price
                    newProduct.image = product.image
                    newProduct.stock = Int16(product.stock)
                    
                    for category in product.category {
                        let newCategory = Category(context: moc)
                        newCategory.name = category
                        newCategory.product = newProduct
                    }
                    
                    for imageGalleryImage in product.imageGallery {
                        let newImage = ImageGallery(context: moc)
                        newImage.image = imageGalleryImage
                        newImage.product = newProduct
                    }
                    
                    if let productSizes = product.sizes {
                        for productSize in productSizes {
                            let newSize = Size(context: moc)
                            newSize.size = Int16(productSize)
                            newSize.product = newProduct
                        }
                    }
                    
                    try? moc.save()
                }
                
            } catch {
                throw error
            }
        } else {
            products = await convertToProductObject(from: cachedProducts)
        }
    }
    
    func getCartProductsReady(_ cartProducts: FetchedResults<Cart>, _ moc: NSManagedObjectContext) {
        cart = convertToCartProductObject(from: cartProducts)
    }
    
    func cdAddToCart(_ product: Product, _ moc: NSManagedObjectContext, _ cachedProducts: FetchedResults<CachedProduct>, size: Int16, quantity: Double) {
        let newCartItem = Cart(context: moc)
        
        for cachedProduct in cachedProducts {
            if cachedProduct.id == product.id {
                cachedProduct.selectedSize = size
                cachedProduct.selectedQuantity = quantity
                newCartItem.addToProducts(cachedProduct)
            }
        }
        
        try? moc.save()
        cart.append(product)
    }
    
    func editCart(_ product: Product, _ cartProducts: FetchedResults<Cart>, _ cachedProducts: FetchedResults<CachedProduct>, _ moc: NSManagedObjectContext, _ size: Int16, _ quantity: Double) {
        removeFromCart(product, cartProducts, cachedProducts, moc)
        cdAddToCart(product, moc, cachedProducts, size: size, quantity: quantity)
    }
    
    func removeFromCart(_ product: Product, _ cartProducts: FetchedResults<Cart>, _ cachedProducts: FetchedResults<CachedProduct>, _ moc: NSManagedObjectContext) {
        for cartProduct in cartProducts {
            for foundCartProduct in cartProduct.productsSet {
                if foundCartProduct.id == product.id {
                    cartProduct.removeFromProducts(foundCartProduct)
                    moc.delete(cartProduct)
                }
            }
        }
        
        try? moc.save()
        cart.removeAll { productToRemove in
            productToRemove.id == product.id
        }
    }
    
    func emptyCart(_ cartProducts: FetchedResults<Cart>, _ moc: NSManagedObjectContext) {
        for cartProduct in cartProducts {
            if let cartProductsToRemove = cartProduct.products {
                cartProduct.removeFromProducts(cartProductsToRemove)
                moc.delete(cartProduct)
            }
        }

        try? moc.save()
        cart = []
    }
    
    func checkIfProductIsInCart(_ product: Product) -> Bool {
        return cart.contains(where: { cdProduct in
            if product.id == cdProduct.id {
                return true
            } else {
                return false
            }
        })
    }
    
    private func convertToProductObject(from cdObject: FetchedResults<CachedProduct>) async -> [Product] {
        var products = [Product]()
        for cachedProduct in cdObject {
            let newProduct = buildProductObject(from: cachedProduct)
            products.append(newProduct)
        }
        
        return products
    }
    
    private func convertToCartProductObject(from cdObject: FetchedResults<Cart>) -> [Product] {
        var productsInCart = [Product]()
        for cartProducts in cdObject {
            for product in cartProducts.productsSet {
                let newCartProduct = buildProductObject(from: product)
                productsInCart.append(newCartProduct)
            }
        }
        
        return productsInCart
    }
    
    private func buildProductObject(from cdProduct: CachedProduct) -> Product {
        let newProduct = Product(
            id: cdProduct.id ?? UUID(),
            name: cdProduct.wrappedName,
            description: cdProduct.wrappedDescription,
            category: cdProduct.categoriesArray,
            price: cdProduct.price,
            stock: Int(cdProduct.stock),
            sizes: cdProduct.sizesArray,
            image: cdProduct.wrappedImage,
            imageGallery: cdProduct.imageGalleryArray
        )
        
        return newProduct
    }
}
