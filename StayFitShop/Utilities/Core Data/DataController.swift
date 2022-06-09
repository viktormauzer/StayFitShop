//
//  DataController.swift
//  StayFitShop
//
//  Created by Viktor Mauzer on 02.06.2022..
//

import Foundation
import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "ShopModel")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("error loading the database \(error.localizedDescription)")
            }
        }
    }
}
