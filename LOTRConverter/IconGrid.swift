//
//  IconGrid.swift
//  LOTRConverter
//
//  Created by Logan Miller on 7/15/24.
//

import SwiftUI

struct IconGrid: View {
    @Binding var currency: Currency
    
    var body: some View {
        LazyVGrid(columns: [GridItem(), GridItem(), GridItem()]) {
            ForEach(Currency.allCases) { currency in
                
                if self.currency == currency {
                    // Selected currency
                    CurrencyIcon(currencyImage: currency.image,
                                 currencyName: currency.name)
                    .shadow(color: .black, radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                    .overlay {
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(lineWidth: 3)
                            .opacity(0.5)
                    }
                } else {
                    // Unselected currency
                    CurrencyIcon(currencyImage: currency.image,
                                 currencyName: currency.name)
                    .onTapGesture {
                        self.currency = currency
                    }
                }
            }
        }
    }
}

#Preview {
    IconGrid(currency: .constant(.copperPenny))
}
