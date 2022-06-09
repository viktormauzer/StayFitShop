//
//  Order.swift
//  StayFitShop
//
//  Created by Viktor Mauzer on 07.06.2022..
//

import Foundation

struct Order: Codable {
    let products: [ProductForPurchase]
    let user: AppUser
}
