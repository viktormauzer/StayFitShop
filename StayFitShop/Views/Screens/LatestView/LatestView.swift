//
//  LatestView.swift
//  StayFitShop
//
//  Created by Viktor Mauzer on 20.05.2022..
//

import SwiftUI

struct LatestView: View {
    
    @StateObject var viewModel = LatestViewModel()
    
    var products: [Product]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    BannerAdvertView(imageName: "advert-banner", promoText: "-50% OFF!")
                    CustomSubtitleView(text: "Products")
                    VerticalProductGridView(viewModel.columns, products)
                }
            }
            .navigationTitle("Latest")
        }
    }
}

struct LatestView_Previews: PreviewProvider {
    static var previews: some View {
        LatestView(products: CoreDataManager.shared.products)
    }
}
