//
//  Currency.swift
//  LOTRConverter
//
//  Created by Logan Miller on 7/15/24.
//

import SwiftUI

extension Currency {
    init?(name: String) {
        switch name {
        case "Copper Penny":
            self.init(rawValue: 6400)
        case "Silver Penny":
            self.init(rawValue: 64)
        case "Silver Piece":
            self.init(rawValue: 16)
        case "Gold Penny":
            self.init(rawValue: 4)
        case "Gold Piece":
            self.init(rawValue: 1)
        default:
            return nil
        }
    }
}

enum Currency: Double, CaseIterable, Identifiable {
    case copperPenny = 6400.0
    case silverPenny = 64.0
    case silverPiece = 16.0
    case goldPenny = 4.0
    case goldPiece = 1.0
    
    var id: Currency { self }
    
    var image: ImageResource {
        switch self {
            case .copperPenny: return .copperpenny
            case .silverPenny: return .silverpenny
            case .silverPiece: return .silverpiece
            case .goldPenny: return .goldpenny
            case .goldPiece: return .goldpiece
        }
    }
    
    var name: String {
        switch self {
            case .copperPenny: return "Copper Penny"
            case .silverPenny: return "Silver Penny"
            case .silverPiece: return "Silver Piece"
            case .goldPenny: return "Gold Penny"
            case .goldPiece: return "Gold Piece"
        }
    }
    
    func convert(_ amountString: String,
                 to currency: Currency) -> String {
        guard let doubleAmount = Double(amountString) else { return "" }
        let convertedAmount = (doubleAmount / self.rawValue) * currency.rawValue
        return String(format: "%.2f", convertedAmount)
    }
}
