//
//  LocalizationItem.swift
//  ItunesSearch
//
//  Created by Berk Akkerman on 20.03.2022.
//

import Foundation

struct LocalizationItem {
    
    let key: String
    let arguments: [CVarArg]?
    
    init(key: String, arguments: [CVarArg]? = nil) {
        self.key = key
        self.arguments = arguments
    }
    
    init(key: String, arguments: CVarArg...) {
        self.key = key
        self.arguments = arguments
    }
}
