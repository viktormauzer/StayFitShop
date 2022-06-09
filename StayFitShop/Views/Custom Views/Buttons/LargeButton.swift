//
//  LargeButton.swift
//  StayFitShop
//
//  Created by Viktor Mauzer on 25.05.2022..
//

import SwiftUI

enum LargeButtonRole {
    case standard, destructive
}

struct LargeButton: View {
    
    var text: String
    var systemImage: String?
    var role: LargeButtonRole?
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            if let systemImage = systemImage {
                Label(text, systemImage: systemImage)
            } else {
                Text(text)
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 44)
        .background(role == .standard ? Color.accentColor : .warningColor)
        .foregroundColor(.white)
        .cornerRadius(18)
        .padding(.vertical)
        .shadow(color: role == .standard ? Color.accentColor.opacity(0.3) : .warningColor.opacity(0.3), radius: 10, x: 0, y: 0)
    }
}

struct LargeButton_Previews: PreviewProvider {
    static var previews: some View {
        LargeButton(text: "Add To Cart", systemImage: "cart.fill.badge.plus") { }
    }
}

