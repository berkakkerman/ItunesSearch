//
//  Decimal+Ext.swift
//  ItunesSearch
//
//  Created by Berk Akkerman on 18.03.2022.
//

import Foundation

extension Decimal {
    
    func formatCurrency(locale: Locale = Locale.current,
                        currencyCode: String) -> String? {
        let formatter = NumberFormatter()
        formatter.locale = locale
        formatter.numberStyle = .currency
        formatter.currencyCode = currencyCode
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        formatter.roundingMode = .down
        let amount: Double = NSDecimalNumber(decimal: self).doubleValue
        let stringValue = formatter.string(from: amount.rounded(toPlaces: 4) as NSNumber? ?? 0)
        return stringValue
    }
}

