//
//  LocalizationKey.swift
//  ItunesSearch
//
//  Created by Berk Akkerman on 20.03.2022.
//

import Foundation

enum LocalizationKeys {
    
    // MARK: - Home
    case home_title
    case product_search_placeholder
    case product_search_empty
    
    // MARK: - Product
    case product_movie
    case product_music
    case product_ebook
    case product_podcast
    case product_release_date
    
    // MARK: - Product Labels
    case product_label_kind
    case product_label_release_date
    case product_label_collection
    case product_label_artist
    case product_label_navigate
    
    var name: String {
        return String("\(self)".split(separator: "(").first ?? "")
    }
    
    var arguments: [CVarArg]? {
        switch self {
        default: return nil
        }
    }
    
    var localization: LocalizationItem {
        return LocalizationItem(key: self.name, arguments: arguments)
    }
}
