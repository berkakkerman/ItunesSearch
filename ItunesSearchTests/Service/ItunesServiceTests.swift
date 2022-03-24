//
//  ItunesServiceTests.swift
//  ItunesSearchTests
//
//  Created by Berk Akkerman on 21.03.2022.
//

import XCTest
import Combine
@testable import ItunesSearch

class ItunesServiceTests: XCTestCase {
    
    // MARK: Service
    var itunesService: ItunesServiceProtocol = FakeItunesService()
    
    // MARK: Subscription
    private var subscription: Set<AnyCancellable> = []
    
    func testGettingProducts() {
        
        var results: [ItunesProduct]?
        let expectation = self.expectation(description: "GetResults")
        
        itunesService.getResults(request: ItunesResultRequest(term: Constants.Default.searchTerm,
                                                              kind: Constants.Default.productKind))
            .sink { (_) in
            } receiveValue: { response in
                results = response.results
                expectation.fulfill()
            }
            .store(in: &subscription)
        
        // Awaiting fulfilment of the expecation before
        // performing our asserts:
        waitForExpectations(timeout: 2)
        
        XCTAssertNotNil(results)
    }
}
