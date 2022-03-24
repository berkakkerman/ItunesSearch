//
//  Constants.swift
//  ItunesSearch
//
//  Created by Berk Akkerman on 18.03.2022.
//

import Foundation

struct Constants {
    
    struct Default {
        static let searchTerm = "The"
        static let productKind: ItunesMediaKind = .movie
    }
    
    struct Network {
        static let baseUrl = "https://itunes.apple.com"
    }
    
    struct Date {
        static let serviceDateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        static let appDateFormat = "dd/MM/yyyy"
    }
    
    struct List {
        static let pageSize = Int(20)
        static let maxSize = Int(200)
    }
}
