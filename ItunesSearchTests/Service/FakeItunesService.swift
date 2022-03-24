//
//  FakeItunesService.swift
//  ItunesSearchTests
//
//  Created by Berk Akkerman on 24.03.2022.
//

import Foundation
import Combine
@testable import ItunesSearch

class FakeItunesService: ItunesServiceProtocol {
    
    func getResults(request: ItunesResultRequest) -> AnyPublisher<ItunesResult, Error> {
        return Just(sampleData)
            .mapError { $0 as Error }
            .eraseToAnyPublisher()
    }
}

private extension FakeItunesService {
    
    var sampleData: ItunesResult {
            ItunesResult(resultCount: 2, results: [
                ItunesProduct.previewValue
            ])
    }
}
