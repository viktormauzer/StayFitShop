//
//  ProductFormView.swift
//  StayFitShop
//
//  Created by Viktor Mauzer on 06.06.2022..
//

import SwiftUI

struct ProductFormView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var cachedProducts: FetchedResults<CachedProduct>
    @FetchRequest(sortDescriptors: []) var cart: FetchedResults<Cart>
    
    var product: Product
    
    @State private var quantity = 1
    @State private var size = 34
    
    var body: some View {
        VStack {
            Text(product.name)
                .font(.largeTitle)
            
            Form {
                Section("Edit Product") {
                    Picker("Quantity", selection: $quantity) {
                        ForEach(1..<product.stock + 1, id: \.self) { quantity in
                            Text("\(quantity)")
                        }
                    }
                    
                    if let sizes = product.sizes {
                        Picker("Size", selection: $size) {
                            ForEach(sizes, id: \.self) { size in
                                Text("\(size)")
                            }
                        }
                    }
                }
                
                Section("Save") {
                    Button {
                        CoreDataManager.shared.editCart(product, cart, cachedProducts, moc, Int16(size), Double(quantity))
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Save Changes")
                    }
                }
            }
        }
    }
}
