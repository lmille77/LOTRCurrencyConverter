//
//  ContentView.swift
//  LOTRConverter
//
//  Created by Logan Miller on 5/15/24.
//

import SwiftUI
import TipKit

struct SelectedCurrencyKeys {
    static let leftCurrency = "leftCurrency"
    static let rightCurrency = "rightCurrency"
}

struct ContentView: View {
    @State var showExchangeInfo = false
    @State var showSelectCurrency = false
    
    @State var leftAmount = ""
    @State var rightAmount = ""
    
    @FocusState var leftTyping
    @FocusState var rightTyping
    
    // Attempt to set to previously selected currency, otherwise set to default value
    @State var leftCurrency: Currency = Currency(name: UserDefaults.standard.string(forKey: SelectedCurrencyKeys.leftCurrency) ?? "") ?? .copperPenny
    @State var rightCurrency: Currency = Currency(name: UserDefaults.standard.string(forKey: SelectedCurrencyKeys.rightCurrency) ?? "") ?? .silverPenny
    
    var body: some View {
        ZStack{
            // Background image
            Image(.background)
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                // App logo
                Image(.prancingpony)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                
                // Label
                Text("Currency Exchange")
                    .font(.largeTitle)
                    .foregroundStyle(.white)
                
                // Conversions
                HStack {
                    // Left conversion section
                    VStack {
                        // Left currency
                        HStack {
                            Image(leftCurrency.image)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 33)
                            Text(leftCurrency.name)
                                .font(.headline)
                                .foregroundStyle(.white)
                        }
                        .padding(.bottom, -5)
                        .onTapGesture {
                            showSelectCurrency.toggle()
                        }
                        .popoverTip(CurrencyTip(),
                                    arrowEdge: .bottom)
                        
                        // Left textfield
                        TextField("Amount",
                                  text: $leftAmount)
                            .textFieldStyle(.roundedBorder)
                            .focused($leftTyping)
                            .keyboardType(.decimalPad)
                    }
                    
                    // Equal sign
                    Image(systemName: "equal")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                    
                    // Right conversion section
                    VStack {
                        // Right currency
                        HStack {
                            Text(rightCurrency.name)
                                .font(.headline)
                                .foregroundStyle(.white)
                            Image(rightCurrency.image)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 33)
                        }
                        .padding(.bottom, -5)
                        .onTapGesture {
                            showSelectCurrency.toggle()
                        }
                        
                        // Right textfield
                        TextField("Amount",
                                  text: $rightAmount)
                            .textFieldStyle(.roundedBorder)
                            .multilineTextAlignment(.trailing)
                            .focused($rightTyping)
                            .keyboardType(.decimalPad)
                    }
                }
                .padding()
                .background(.black.opacity(0.5))
                .clipShape(.capsule)
                
                Spacer()
                HStack {
                    Spacer()
                    
                    Button {
                        showExchangeInfo.toggle()
                    } label: {
                        Image(systemName: "info.circle.fill")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                    }.padding(.trailing)
                }
            }
        }.task {
            try? Tips.configure()
        }

        // Observables
        .onChange(of: leftCurrency) {
            leftAmount = rightCurrency.convert(rightAmount,
                                               to: leftCurrency)
            // Save new selection
            UserDefaults.standard.setValue(leftCurrency.name,
                                           forKey: SelectedCurrencyKeys.leftCurrency)
        }
        
        .onChange(of: rightCurrency) {
            rightAmount = leftCurrency.convert(leftAmount,
                                               to: rightCurrency)
            
            // Save new selection
            UserDefaults.standard.setValue(rightCurrency.name,
                                           forKey: SelectedCurrencyKeys.rightCurrency)
        }
        
        .onChange(of: leftAmount) {
            if leftTyping {
                rightAmount = leftCurrency.convert(leftAmount,
                                                   to: rightCurrency)
            }
        }
        
        .onChange(of: rightAmount) {
            if rightTyping {
                leftAmount = rightCurrency.convert(rightAmount,
                                                   to: leftCurrency)
            }
        }
        
        .sheet(isPresented: $showExchangeInfo) {
            ExchangeInfo()
        }
        
        .sheet(isPresented: $showSelectCurrency, content: {
            SelectCurrency(topCurrency: $leftCurrency,
                           bottomCurrency: $rightCurrency)
        })
        
        .onTapGesture {
            self.hideKeyboard()
        }
        
    }
}

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

#Preview {
    ContentView()
}
