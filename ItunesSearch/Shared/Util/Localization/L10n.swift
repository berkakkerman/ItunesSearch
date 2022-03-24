//
//  L10n.swift
//  ItunesSearch
//
//  Created by Berk Akkerman on 20.03.2022.
//

import Foundation

class L10n {
    
    static func tr(with item: LocalizationItem) -> String {
        let value = NSLocalizedString(item.key, comment: "")
        guard let arguments = item.arguments else { return value }
        return String(format: value, arguments: arguments.map { String(describing: $0) })
    }
}

extension L10n {
    
    static func tr(_ key: LocalizationKeys) -> String {
        return tr(with: key.localization)
    }
    
    static func tr(_ key: String) -> String {
        return tr(with: LocalizationItem(key: key))
    }
}
