//
//  CheckoutViewModel.swift
//  StayFitShop
//
//  Created by Viktor Mauzer on 07.06.2022..
//

import SwiftUI
import CoreData

@MainActor final class CheckoutViewModel: ObservableObject {
    
    let networkManager = NetworkManager()
    
    @Published var products = [Product]()
    
    @Published var firstName = ""
    @Published var lastName = ""
    @Published var address = ""
    @Published var zip = ""
    @Published var city = ""
    @Published var country = ""
    @Published var isShowingProfileModal = false
    
    @Published var isShowingOrderCompleteAlert = false
    @Published var isShowingOrderErrorAlert = false
    @Published var isShowingLoadingScreen = false
    
    
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
    
    func loadProfile(_ users: FetchedResults<User>) {
        for user in users {
            firstName = user.wrappedFirstName
            lastName = user.wrappedLastName
            address = user.wrappedAddress
            zip = user.wrappedZip
            city = user.wrappedCity
            country = user.wrappedCountry
        }
    }
    
    func createOrder(_ cachedProducts: FetchedResults<CachedProduct>, _ cartProducts: FetchedResults<Cart>, _ moc: NSManagedObjectContext) async {
        isShowingLoadingScreen = true
        let user = AppUser(firstName: firstName, lastName: lastName, address: address, zip: zip, city: city, country: country)
        
        var productsForPurchase = [ProductForPurchase]()
        
        for product in products {
            let productForPurchase = ProductForPurchase(name: product.name, price: product.price * getQuantity(product, cachedProducts), size: getSize(product, cachedProducts) ?? 34)
            productsForPurchase.append(productForPurchase)
        }
        
        let order = Order(products: productsForPurchase, user: user)
        
        do {
            try await networkManager.placeOrder(order)
            emptyCart(cartProducts, moc)
            isShowingOrderCompleteAlert = true
            isShowingLoadingScreen = false
        } catch {
            isShowingLoadingScreen = false
            isShowingOrderErrorAlert = true
        }
    }
    
    private func emptyCart(_ cartProducts: FetchedResults<Cart>, _ moc: NSManagedObjectContext) {
        CoreDataManager.shared.emptyCart(cartProducts, moc)
    }
}
