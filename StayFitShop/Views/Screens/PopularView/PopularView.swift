//
//  PopularView.swift
//  StayFitShop
//
//  Created by Viktor Mauzer on 23.05.2022..
//

import SwiftUI

struct PopularView: View {
    
    @StateObject var viewModel = PopularViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    CustomSubtitleView(text: "Shoes")
                    HorizontalProductGridView(viewModel.rows, viewModel.shoesCategory)
                    
                    CustomSubtitleView(text: "Hats")
                    VerticalProductGridView(viewModel.columns, viewModel.hatsCategory)
                    
                    CustomSubtitleView(text: "Weights")
                    HorizontalProductGridView(viewModel.rows, viewModel.weightsCategory)
                }
                .navigationTitle("Popular")
                .task {
                    await viewModel.setCategories()
                }
            }
        }
    }
}

struct PopularView_Previews: PreviewProvider {
    static var previews: some View {
        PopularView()
    }
}
