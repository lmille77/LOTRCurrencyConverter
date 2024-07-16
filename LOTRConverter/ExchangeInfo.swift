//
//  ExchangeInfo.swift
//  LOTRConverter
//
//  Created by Logan Miller on 5/20/24.
//

import SwiftUI

struct ExchangeInfo: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            // Background image
            Image(.parchment)
                .resizable()
                .ignoresSafeArea()
                .background(.brown)
            
            VStack {
                // Title text
                Text("Exchange Rates")
                    .font(.largeTitle)
                    .tracking(3)
                
                // Description text
                Text("Here at the Prancing Pony, we are happy to offer you a place where you can exchange all the known currencies in the entire world except one. We used to take Brandy Bucks, but after finding out that it was a person instead of a piece of paper, we realized it had no value to us. Below is a simple guide to our currency exchange rates:")
                    .font(.title2)
                    .padding()
                
                // Exchange rates
                ExchangeRate(leftImage: .goldpiece, rightImage: .goldpiece, textContent: "1 Gold Piece = 4 Gold Pennies")
                ExchangeRate(leftImage: .goldpenny, rightImage: .silverpiece, textContent: "1 Gold Penny = 4 Silver Pieces")
                ExchangeRate(leftImage: .silverpiece, rightImage: .silverpenny, textContent: "1 Silver Piece = 4 Silver Pennies")
                ExchangeRate(leftImage: .silverpenny, rightImage: .copperpenny, textContent: "1 Silver Penny = 100 Copper Pennies")
                
                // done
                Button("Done") {
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
                .tint(.brown)
                .font(.largeTitle)
                .padding()
                .foregroundColor(.white)

            }.foregroundStyle(.black)
        }
        

    }
}

#Preview {
    ExchangeInfo()
}
