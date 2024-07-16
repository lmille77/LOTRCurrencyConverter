//
//  SelectCurrency.swift
//  LOTRConverter
//
//  Created by Logan Miller on 7/15/24.
//

import SwiftUI

struct SelectCurrency: View {
    @Environment(\.dismiss) var dismiss
    @Binding var topCurrency: Currency
    @Binding var bottomCurrency: Currency
    
    var body: some View {
        ZStack {
            // Parchment background image
            Image(.parchment)
                .resizable()
                .ignoresSafeArea()
                .background(.brown)
            
            VStack {
                // Text
                Text("Select the currency you are starting with:")
                    .fontWeight(.bold)
                
                // Top currency
                IconGrid(currency: $topCurrency)

                // Text
                Text("Select the currency you would like to convert to:")
                    .fontWeight(.bold)
                
                // Bottom currency
                IconGrid(currency: $bottomCurrency)
                
                // Done button
                Button("Done") {
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
                .tint(.brown)
                .font(.largeTitle)
                .padding()
                .foregroundColor(.white)
            }
            .padding()
            .multilineTextAlignment(.center)
        }
  
    }
}

#Preview {
    SelectCurrency(topCurrency: .constant(.copperPenny),
                   bottomCurrency: .constant(.silverPenny))
}
