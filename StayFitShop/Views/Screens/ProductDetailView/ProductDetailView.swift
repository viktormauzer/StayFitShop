//
//  ProductDetailView.swift
//  StayFitShop
//
//  Created by Viktor Mauzer on 23.05.2022..
//

import SwiftUI

struct ProductDetailView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var cachedProducts: FetchedResults<CachedProduct>
    @FetchRequest(sortDescriptors: []) var cart: FetchedResults<Cart>
    
    @ObservedObject var viewModel: ProductDetailViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                VStack {
                    ProductImageView(imageName: viewModel.product.imageGallery[viewModel.selectedImageIndex])
                    
                    SingleProductGalleryView(product: viewModel.product, selectedImageIndex: $viewModel.selectedImageIndex)
                }
                .padding(.bottom)
                
                VStack(alignment: .leading) {
                    Text(viewModel.product.name)
                        .font(.title)
                        .multilineTextAlignment(.leading)
                    
                    Text(viewModel.product.formatPrice(viewModel.quantity))
                        .font(.largeTitle)
                        .fontWeight(.black)
                        .multilineTextAlignment(.leading)
                    
                    Text(viewModel.product.stock > 0 ? "Stock: \(viewModel.product.stock)" : "Out of stock")
                        .font(.caption)
                        .foregroundColor(viewModel.product.stock > 0 ? .primary : .red)
                    
                    Text(viewModel.product.description)
                        .padding(.vertical, 1)
                    
                    HStack {
                        ForEach(viewModel.product.category, id: \.self) { category in
                            Text(category)
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                    
                    CustomSubtitleView(text: "ORDER:")
                    
                    if let sizes = viewModel.product.sizes {
                        SizePickerView(sizes: sizes, size: $viewModel.size)
                    }
                    
                    Stepper("Quantity: \(viewModel.quantity.formatted())", value: $viewModel.quantity, in: 1...10)
                    
                    
                    if viewModel.isInCart {                        
                        LargeButton(text: "Remove From Cart", systemImage: "cart.fill.badge.minus", role: .destructive) {
                            CoreDataManager.shared.removeFromCart(viewModel.product, cart, cachedProducts, moc)
                            viewModel.isInCart = CoreDataManager.shared.checkIfProductIsInCart(viewModel.product)
                            playHaptic(.warning)
                        }
                    } else {
                        LargeButton(text: "Add To Cart", systemImage: "cart.fill.badge.plus", role: .standard) {
                            CoreDataManager.shared.cdAddToCart(viewModel.product, moc, cachedProducts, size: Int16(viewModel.size), quantity: viewModel.quantity)
                            viewModel.isInCart = CoreDataManager.shared.checkIfProductIsInCart(viewModel.product)
                            playHaptic(.success)
                        }
                        .disabled(viewModel.product.stock <= 0)
                    }
                }
                .padding(.horizontal, 8)
            }
            .padding(.horizontal)
            .navigationTitle(viewModel.product.name)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(content: {
                if viewModel.isInCart {
                    Button {
                        CoreDataManager.shared.removeFromCart(viewModel.product, cart, cachedProducts, moc)
                        viewModel.isInCart = CoreDataManager.shared.checkIfProductIsInCart(viewModel.product)
                        playHaptic(.warning)
                    } label: {
                        Label("Remove From Cart", systemImage: "cart.fill.badge.minus")
                            .foregroundColor(.warningColor)
                    }
                }
            })
            .onAppear {
                viewModel.isInCart = CoreDataManager.shared.checkIfProductIsInCart(viewModel.product)
            }
        }
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProductDetailView(viewModel: ProductDetailViewModel(product: Product.mockDataSingle()))
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

