//
//  ExchangeRate.swift
//  LOTRConverter
//
//  Created by Logan Miller on 5/20/24.
//

import SwiftUI

struct ExchangeRate: View {
    let leftImage: ImageResource
    let rightImage: ImageResource
    let textContent: String
    
    var body: some View {
        HStack {
            // Left image
            Image(leftImage)
                .resizable()
                .scaledToFit()
                .frame(height: 33)
            
            // Text
            Text(textContent)
            
            // Right image
            Image(rightImage)
                .resizable()
                .scaledToFit()
                .frame(height: 33)
        }
    }
}
