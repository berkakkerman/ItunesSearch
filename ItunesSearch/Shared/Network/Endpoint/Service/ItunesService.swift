//
//  ItunesService.swift
//  ItunesSearch
//
//  Created by Berk Akkerman on 18.03.2022.
//

import Foundation
import Combine

protocol ItunesServiceProtocol {
    func getResults(request: ItunesResultRequest) -> AnyPublisher<ItunesResult, Error>
}

class ItunesService {
    
    private let networking: NetworkingProtocol
    
    init(networking: NetworkingProtocol) {
        self.networking = networking
    }
}

// MARK: - ItunesServiceProtocol
extension ItunesService: ItunesServiceProtocol {
    
    func getResults(request: ItunesResultRequest) -> AnyPublisher<ItunesResult, Error> {
        return networking.execute(endpoint: ItunesEndpoint.getResults(request), decodingType: ItunesResult.self)
    }
}
