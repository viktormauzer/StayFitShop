//
//  Product.swift
//  StayFitShop
//
//  Created by Viktor Mauzer on 25.05.2022..
//

import Foundation
import UIKit

struct Product: Identifiable, Codable {
    let id: UUID
    let name: String
    let description: String
    var category: [String] = ["Uncategorized"]
    let price: Double
    var stock: Int = 0
    let sizes: [Int]?
    let image: String
    let imageGallery: [String]
    
    func formatPrice(_ quantity: Double = 1.0) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "de_DE") // locale for testing purposes
        
        return formatter.string(from: NSNumber(value: price * quantity)) ?? "0 €"
    }
    
    
    //MARK: - MockData Methods
    
    static func mockDataArray(productsNumber: Int) -> [Product] {
        var products = [Product]()
        for _ in 1...productsNumber {
            let product = Product(id: UUID(), name: "Product Name", description: "Integer ante diam, sagittis feugiat ullamcorper ut, facilisis vel ipsum. Nullam metus diam, efficitur eu mi id, commodo feugiat magna. Nulla posuere lorem a libero facilisis, vitae aliquet orci tempor. Aliquam mi neque, egestas vitae sem nec, pharetra vulputate sem. Ut posuere rhoncus augue tincidunt accumsan.", price: 29.99, sizes: nil, image: "https://viktormauzer.github.io/files/portfolio-shop/img/shoes/ColorfulShoe.jpg", imageGallery: ["https://viktormauzer.github.io/files/portfolio-shop/img/shoes/ColorfulShoe.jpg"])
            products.append(product)
        }
        return products
    }
    
    static func mockDataSingle() -> Product {
        let product = Product(id: UUID(), name: "Product Name", description: "Integer ante diam, sagittis feugiat ullamcorper ut, facilisis vel ipsum. Nullam metus diam, efficitur eu mi id, commodo feugiat magna. Nulla posuere lorem a libero facilisis, vitae aliquet orci tempor. Aliquam mi neque, egestas vitae sem nec, pharetra vulputate sem. Ut posuere rhoncus augue tincidunt accumsan.", price: 29.99, sizes: nil, image: "https://viktormauzer.github.io/files/portfolio-shop/img/shoes/ColorfulShoe.jpg", imageGallery: ["https://viktormauzer.github.io/files/portfolio-shop/img/shoes/ColorfulShoe.jpg"])
        return product
    }
}
