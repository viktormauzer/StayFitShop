//
//  LatestViewModel.swift
//  StayFitShop
//
//  Created by Viktor Mauzer on 07.06.2022..
//

import SwiftUI

@MainActor final class LatestViewModel: ObservableObject {
    var columns = [GridItem(.flexible()), GridItem(.flexible())]
    var products = CoreDataManager.shared.products
}
