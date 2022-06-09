//
//  AppUser.swift
//  StayFitShop
//
//  Created by Viktor Mauzer on 07.06.2022..
//

import Foundation

struct AppUser: Codable {
    let firstName: String
    let lastName: String
    let address: String
    let zip: String
    let city: String
    let country: String
}
