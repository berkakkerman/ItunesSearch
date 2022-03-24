//
//  ItunesEndpoint.swift
//  ItunesSearch
//
//  Created by Berk Akkerman on 18.03.2022.
//

import Foundation

enum ItunesEndpoint {
    case getResults(_ request: ItunesResultRequest)
}

extension ItunesEndpoint: EndpointProtocol {
    
    var baseURL: String {
        return Constants.Network.baseUrl
    }
    
    var path: String {
        switch self {
        case .getResults: return "/search"
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .getResults: return .get
        }
    }
    
    var headers: [String: String]? {
        switch self {
        default: return [String: String]()
        }
    }
    
    var parameters: RequestParameters? {
        switch self {
        case .getResults(let request):
            return request.queryParameters
        }
    }
    
    var body: Encodable? {
        switch self {
        default: return nil
        }
    }
}
