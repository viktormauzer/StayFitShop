//
//  HorizontalProductGridView.swift
//  StayFitShop
//
//  Created by Viktor Mauzer on 25.05.2022..
//

import SwiftUI

struct HorizontalProductGridView: View {
    
    var rows: [GridItem]
    var products: [Product]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows: rows) {
                ForEach(products) { product in
                    NavigationLink(destination: ProductDetailView(viewModel: ProductDetailViewModel(product: product))) {
                        CustomGridItemView(gridItemType: .horizontal, product: product)
                            .padding(8)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .padding(.horizontal)
        }
    }
    
    init(_ rows: [GridItem], _ products: [Product]) {
        self.rows = rows
        self.products = products
    }
}

struct HorizontalProductGridView_Previews: PreviewProvider {
    static var previews: some View {
        let rows = [GridItem(.fixed(200))]
        let products: [Product] = Product.mockDataArray(productsNumber: 10)
        
        HorizontalProductGridView(rows, products)
    }
}
