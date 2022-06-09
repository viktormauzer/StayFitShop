//
//  CustomSubtitleView.swift
//  StayFitShop
//
//  Created by Viktor Mauzer on 23.05.2022..
//

import SwiftUI

struct CustomSubtitleView: View {
    
    var text: String
    
    var body: some View {
        Text(text)
            .font(.title2)
            .bold()
            .padding(.top, 26)
    }
}
