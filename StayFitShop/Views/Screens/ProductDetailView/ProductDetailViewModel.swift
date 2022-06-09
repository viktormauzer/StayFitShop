//
//  ProductDetailViewModel.swift
//  StayFitShop
//
//  Created by Viktor Mauzer on 25.05.2022..
//

import SwiftUI

@MainActor final class ProductDetailViewModel: ObservableObject {
    var product: Product
    
    @Published var price = 0.0
    @Published var quantity = 1.0
    @Published var selectedColor = "black"
    @Published var selectedImageIndex = 0
    @Published var size = 0
    @Published var isInCart = false
    
    init(product: Product, quantity: Double = 1.0, size: Int? = 0) {
        self.product = product
        self.quantity = quantity
        self.size = size ?? 0
    }
}
