//
//  Ext+Double.swift
//  StayFitShop
//
//  Created by Viktor Mauzer on 06.06.2022..
//

import Foundation

extension Double {
    func formatedPrice() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "de_DE") // locale for testing purposes
        
        return formatter.string(from: NSNumber(value: self)) ?? "0 €"
    }
}
