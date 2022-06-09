//
//  StayFitShopApp.swift
//  StayFitShop
//
//  Created by Viktor Mauzer on 09.06.2022..
//

import SwiftUI

@main
struct StayFitShopApp: App {
    
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            AppTabView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
