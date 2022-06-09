//
//  LoadingView.swift
//  StayFitShop
//
//  Created by Viktor Mauzer on 07.06.2022..
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack {
            ProgressView()
                .padding()
            Text("Please wait...")
        }
        .padding(25)
        .background(Color(uiColor: .secondarySystemBackground))
        .cornerRadius(18)
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
