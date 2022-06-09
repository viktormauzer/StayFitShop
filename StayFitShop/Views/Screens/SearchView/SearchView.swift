//
//  SearchView.swift
//  StayFitShop
//
//  Created by Viktor Mauzer on 03.06.2022..
//

import SwiftUI
import SDWebImageSwiftUI
import CoreData

struct SearchView: View {
    @State private var products: [Product] = []
    @State private var searchText = ""
    
    var searchResults: [Product] {
        if searchText == "" {
            return products
        } else {
            return products.filter { $0.name.contains(searchText) }
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                SearchableProducts(searchResults: searchResults, searchText: $searchText)
            }
            .searchable(text: $searchText)
            .navigationTitle("Search")
            .task {
                products = CoreDataManager.shared.products
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}


struct SearchableProducts: View {
    @Environment(\.isSearching) var isSearching
    
    var searchResults: [Product]
    @Binding var searchText: String
    
    var body: some View {
        ForEach(searchResults) { resultProduct in
            NavigationLink(destination: ProductDetailView(viewModel: ProductDetailViewModel(product: resultProduct))) {
                HStack {
                    WebImage(url: URL(string: resultProduct.image))
                        .resizable()
                        .indicator(.activity)
                        .frame(width: 60, height: 60)
                        .cornerRadius(18)
                        .scaledToFit()
                        .padding(.trailing, 8)
                    
                    VStack(alignment: .leading) {
                        Text(resultProduct.name)
                            .bold()
                        
                        HStack {
                            ForEach(resultProduct.category, id: \.self) { category in
                                Text(category)
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                    .italic()
                                    .lineLimit(1)
                            }
                        }
                    }
                }
                .padding(.vertical, 8)
            }
        }
        .onChange(of: isSearching) { newValue in
            if !newValue {
                searchText = ""
            }
        }
    }
}
