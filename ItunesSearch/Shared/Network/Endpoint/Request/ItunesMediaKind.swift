//
//  ItunesProductKind.swift
//  ItunesSearch
//
//  Created by Berk Akkerman on 18.03.2022.
//

import Foundation

enum ItunesMediaKind: String, Codable, CaseIterable {
    
    case movie = "feature-movie"
    case song
    case ebook
    case podcast
    
    var entityName: String {
        switch self {
        case .movie:
            return "movie"
        default:
            return self.rawValue
        }
    }
}

// MARK: Segmentable
protocol Segmentable: Hashable {
    var friendlyName: String { get }
}

extension ItunesMediaKind: Segmentable {
    
    var friendlyName: String {
        switch self {
        case .movie:
            return L10n.tr(.product_movie)
        case .song:
            return L10n.tr(.product_music)
        case .ebook:
            return L10n.tr(.product_ebook)
        case .podcast:
            return L10n.tr(.product_podcast)
        }
    }
}
