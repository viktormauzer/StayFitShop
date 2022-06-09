//
//  CartViewModel.swift
//  StayFitShop
//
//  Created by Viktor Mauzer on 06.06.2022..
//

import SwiftUI
import CoreData

@MainActor final class CartViewModel: ObservableObject {
    
    @Published var products: [Product] = []
    @Published var totalPrice: Double = 0.0
    
    func getQuantity(_ product: Product, _ cachedProducts: FetchedResults<CachedProduct>) -> Double {
        for cachedProduct in cachedProducts {
            if cachedProduct.id == product.id {
                return cachedProduct.selectedQuantity
            }
        }
        return 1.0
    }
    
    func getSize(_ product: Product, _ cachedProducts: FetchedResults<CachedProduct>) -> Int? {
        for cachedProduct in cachedProducts {
            if cachedProduct.id == product.id {
                return Int(cachedProduct.selectedSize)
            }
        }
        return nil
    }
    
    func calculateTotalPrice(_ cachedProducts: FetchedResults<CachedProduct>) {
        if !products.isEmpty {
            var price = 0.0
            for product in products {
                price += product.price * getQuantity(product, cachedProducts)
            }
            totalPrice = price
        } else {
            totalPrice = 0.0
        }
    }
    
    func removeCartItem(_ product: Product, _ cachedProducts: FetchedResults<CachedProduct>, _ cart: FetchedResults<Cart>, _ moc: NSManagedObjectContext) {
        CoreDataManager.shared.removeFromCart(product, cart, cachedProducts, moc)
        products.removeAll { productToRemove in
            product.id == productToRemove.id
        }
        calculateTotalPrice(cachedProducts)
    }
    
    func emptyCart(_ cachedProducts: FetchedResults<CachedProduct>, _ cart: FetchedResults<Cart>, _ moc: NSManagedObjectContext) {
        CoreDataManager.shared.emptyCart(cart, moc)
        products = []
        calculateTotalPrice(cachedProducts)
    }
}
