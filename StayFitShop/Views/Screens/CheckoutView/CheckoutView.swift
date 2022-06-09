//
//  CheckoutView.swift
//  StayFitShop
//
//  Created by Viktor Mauzer on 06.06.2022..
//

import SwiftUI

struct CheckoutView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var cachedProducts: FetchedResults<CachedProduct>
    @FetchRequest(sortDescriptors: []) var cart: FetchedResults<Cart>
    @FetchRequest(sortDescriptors: []) var users: FetchedResults<User>
    
    @StateObject var viewModel = CheckoutViewModel()
    
    var orderTotal: Double
    
    var body: some View {
        ZStack {
            VStack {
                List {
                    Section("Products") {
                        ForEach(viewModel.products) { product in
                            HStack {
                                Text(product.name)
                                Spacer()
                                Text("\(Int(viewModel.getQuantity(product, cachedProducts))) x \(product.price.formatedPrice())")
                            }
                        }
                    }
                    
                    if !users.isEmpty {
                        CheckoutUserInfoView(
                            firstName: viewModel.firstName,
                            lastName: viewModel.lastName,
                            address: viewModel.address,
                            zip: viewModel.zip,
                            city: viewModel.city,
                            country: viewModel.country
                        )
                        
                    } else {
                        Section("Create profile") {
                            Button {
                                viewModel.isShowingProfileModal = true
                            } label: {
                                Label("Create profile", systemImage: "person.fill.badge.plus")
                            }
                        }
                    }
                    
                    Section("Order Total") {
                        Text(orderTotal.formatedPrice())
                            .font(.largeTitle)
                            .fontWeight(.bold)
                    }
                    
                    LargeButton(text: "Complete Order & Pay", role: .standard) {
                        Task {
                            playHaptic(.success)
                            await viewModel.createOrder(cachedProducts, cart, moc)
                        }
                    }
                    .disabled(users.isEmpty)
                    .alert("Thank you!", isPresented: $viewModel.isShowingOrderCompleteAlert) {
                        Button("OK", action: { self.presentationMode.wrappedValue.dismiss() })
                    } message: {
                        Text("Thank you for shopping with us. Your products are on their way.")
                    }
                    .alert("Error", isPresented: $viewModel.isShowingOrderErrorAlert) {
                        Button("OK", action: {})
                    } message: {
                        Text("There was something wrong with your order. Please try again later.")
                    }
       
                    if users.isEmpty {
                        Text("Creating a profile is necessary before completing the order.")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                    }
                }
                .listStyle(PlainListStyle())
            }
            if viewModel.isShowingLoadingScreen {
                LoadingView()
            }
        }
        
        .navigationTitle("Checkout")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $viewModel.isShowingProfileModal, content: {
            ProfileView(isModallyPresented: true)
                .onDisappear {
                    viewModel.loadProfile(users)
                }
        })
        .onAppear {
            viewModel.products = CoreDataManager.shared.cart
            viewModel.loadProfile(users)
        }
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(orderTotal: 1.0)
    }
}

struct CheckoutUserInfoView: View {
    
    var firstName: String
    var lastName: String
    var address: String
    var zip: String
    var city: String
    var country: String
    
    var body: some View {
        Section("Personal Information") {
            VStack {
                CheckoutPersonalInfoRow(leftSideText: "First Name", rightSideText: firstName)
                CheckoutPersonalInfoRow(leftSideText: "Last Name", rightSideText: lastName)
                CheckoutPersonalInfoRow(leftSideText: "Address", rightSideText: address)
                CheckoutPersonalInfoRow(leftSideText: "Zip", rightSideText: zip)
                CheckoutPersonalInfoRow(leftSideText: "City", rightSideText: city)
                CheckoutPersonalInfoRow(leftSideText: "Country", rightSideText: country)
            }
            
        }
    }
}

struct CheckoutPersonalInfoRow: View {
    
    var leftSideText: String
    var rightSideText: String
    
    var body: some View {
        HStack {
            Text(leftSideText)
                .multilineTextAlignment(.leading)
            Spacer()
            Text(rightSideText)
                .multilineTextAlignment(.trailing)
        }
        .font(.callout)
        .foregroundColor(.secondary)
    }
}
