//
//  GridItemView.swift
//  StayFitShop
//
//  Created by Viktor Mauzer on 20.05.2022..
//

import SwiftUI
import SDWebImageSwiftUI

enum GridItemType {
    case vertical, horizontal
}

struct CustomGridItemView: View {
    
    var gridItemType: GridItemType
    var product: Product
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack {
                Rectangle()
                    .foregroundColor(Color(uiColor: .secondarySystemBackground))
                    .cornerRadius(18)
                
                WebImage(url: URL(string: product.image))
                    .resizable()
                    .indicator(.activity)
                    .cornerRadius(18)
                    .scaledToFit()
                    .shadow(color: .primary.opacity(0.2), radius: 5, x: 0, y: 0)
                
                if CoreDataManager.shared.checkIfProductIsInCart(product) {
                    AddedToCartIcon()
                }
                 
            }
            .aspectRatio(1.0, contentMode: .fit)
            
            VStack(alignment: .leading) {
                Text(product.name)
                    .font(.callout)
                    .lineLimit(1)
                
                Text(product.formatPrice())
                    .font(.title3)
                    .fontWeight(.bold)
                
                Text(product.stock > 0 ? "In stock" : "Out of stock")
                    .foregroundColor(product.stock > 0 ? .green : .red)
                    .font(.caption2)
            }
        }
        .frame(width: gridItemType == .horizontal ? 140 : nil)
    }
}

struct GridItemView_Previews: PreviewProvider {
    static var previews: some View {
        CustomGridItemView(gridItemType: .vertical, product: Product.mockDataSingle())
    }
}

struct AddedToCartIcon: View {
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Image(systemName: "cart.circle.fill")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(.white)
                    .padding(8)
                    .background(Color.accentColor)
                    .cornerRadius(18)
                    .padding(16)
                    .offset(x: 25, y: -25)
                    .shadow(color: .primary.opacity(0.2), radius: 5, x: 0, y: 0)
            }
            Spacer()
        }
    }
}
