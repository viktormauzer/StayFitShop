//
//  VerticalProductGridView.swift
//  StayFitShop
//
//  Created by Viktor Mauzer on 25.05.2022..
//

import SwiftUI

struct VerticalProductGridView: View {
    
    var columns: [GridItem]
    var cachedProducts: [Product]
    
    var body: some View {
        LazyVGrid(columns: columns) {
            ForEach(cachedProducts) { product in
                NavigationLink(destination: ProductDetailView(viewModel: ProductDetailViewModel(product: product))) {
                    CustomGridItemView(gridItemType: .vertical, product: product)
                        .padding(16)
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
        .padding(.horizontal, 4)
    }
    
    init(_ columns: [GridItem], _ products: [Product]) {
        self.columns = columns
        self.cachedProducts = products
    }
}
