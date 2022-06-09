//
//  CartView.swift
//  StayFitShop
//
//  Created by Viktor Mauzer on 06.06.2022..
//

import SwiftUI
import SDWebImageSwiftUI

struct CartView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var cachedProducts: FetchedResults<CachedProduct>
    @FetchRequest(sortDescriptors: []) var cart: FetchedResults<Cart>
    
    @StateObject var viewModel = CartViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                if !viewModel.products.isEmpty {
                    List {
                        Section("Products") {
                            ForEach(viewModel.products) { product in
                                NavigationLink(destination: ProductFormView(product: product)) {
                                    CartProductItemView(
                                        product: product,
                                        viewModel: viewModel,
                                        cachedProducts: cachedProducts
                                    )
                                }
                                .swipeActions {
                                    Button {
                                        viewModel.removeCartItem(product, cachedProducts, cart, moc)
                                    } label: {
                                        Label("Remove", systemImage: "cart.fill.badge.minus")
                                    }
                                    .tint(.warningColor)
                                }
                            }
                        }
                        
                        Section("Total") {
                            TotalAmountView(totalPrice: viewModel.totalPrice)
                        }
                        
                        Section("Checkout") {
                            NavigationLink {
                                CheckoutView(orderTotal: viewModel.totalPrice)
                            } label: {
                                Label("Checkout", systemImage: "creditcard.fill")
                            }
                        }
                    }
                } else {
                    VStack {
                        Image("AppIconImage")
                            .resizable()
                            .scaledToFit()
                        Text("Cart is empty")
                            .font(.title)
                            .bold()
                            .padding(.bottom)
                        Text("Please add products to cart before purchase.")
                            .font(.callout)
                            .multilineTextAlignment(.center)
                    }
                    .offset(y: -50)
                }
            }
            .navigationTitle("Cart")
            .toolbar(content: {
                if !CoreDataManager.shared.cart.isEmpty {
                    Button {
                        viewModel.emptyCart(cachedProducts, cart, moc)
                        playHaptic(.warning)
                    } label: {
                        Label("Empty cart", systemImage: "cart.badge.minus")
                            .foregroundColor(.warningColor)
                    }
                }
            })
            .onAppear {
                viewModel.products = CoreDataManager.shared.cart
                viewModel.calculateTotalPrice(cachedProducts)
            }
        }
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
    }
}

struct CartProductItemView: View {
    
    var product: Product
    var viewModel: CartViewModel
    var cachedProducts: FetchedResults<CachedProduct>
    
    var body: some View {
        HStack {
            WebImage(url: URL(string: product.image))
                .resizable()
                .indicator(.activity)
                .frame(width: 44, height: 44)
                .cornerRadius(18)
                .scaledToFit()
            
            VStack(alignment: .leading) {
                Text(product.name)
                Text(String(format: "Quantity: %.0f", viewModel.getQuantity(product, cachedProducts)))
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .italic()
                    .lineLimit(1)
            }
            
            Spacer()
            
            Text(product.formatPrice(viewModel.getQuantity(product, cachedProducts)))
                .font(.caption)
        }
        .padding(.vertical, 8)
    }
}

struct TotalAmountView: View {
    
    var totalPrice: Double
    
    var body: some View {
        HStack {
            Image(systemName: "banknote.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 44)
                .padding(.horizontal)
                .foregroundColor(.accentColor)
            
            VStack(alignment: .leading) {
                Text(totalPrice.formatedPrice())
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text("Tax included at 25% rate.")
                    .foregroundColor(.secondary)
                    .font(.caption2)
                
                Text("Tax amount: \((totalPrice * 0.25).formatedPrice())")
                    .font(.caption)
            }
        }
    }
}
