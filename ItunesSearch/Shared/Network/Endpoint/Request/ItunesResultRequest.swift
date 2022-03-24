//
//  ItunesResultRequest.swift
//  ItunesSearch
//
//  Created by Berk Akkerman on 18.03.2022.
//

import Foundation

protocol Queryble {
    var queryParameters: [String: String] { get }
}

// MARK: - ItunesResultRequest
struct ItunesResultRequest: Codable, Hashable, Queryble {
    
    let term: String
    let kind: ItunesMediaKind
    var limit: Int = Constants.List.maxSize
    
    var queryParameters: [String: String] {
        return [
            "term": term,
            "entity": kind.entityName,
            "limit" : String(limit)
        ]
    }
}
