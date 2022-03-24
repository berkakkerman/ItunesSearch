//
//  Datamodel.swift
//  ItunesSearch
//
//  Created by Berk Akkerman on 23.03.2022.
//

import Combine

final class ProductListEntity: ObservableObject {
    
    var provider: ItunesService
    
    @Published var result: ItunesResult = .init(resultCount: 0)
    @Published var pageCount: Int = 0
    @Published var isLoading: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    
    init(provider: ItunesService = ItunesService(networking: Networking(networkSession: NetworkSession()))) {
        self.provider = provider
    }
    
    func getResults(searchTerm: String, kind: ItunesMediaKind, page: Int) {
        let request = ItunesResultRequest(term: searchTerm, kind: kind)
        
        self.isLoading = true
        
        provider.getResults(request: request)
        // TODO: Handle Error
            .assertNoFailure()
            .map { [weak self] result in
                guard let self = self else { return ItunesResult(resultCount: 0) }                
                self.isLoading = false
                let pages = result.results.chunked(into: Constants.List.pageSize)
                    
                self.pageCount = pages.count
                guard page < pages.count else { return ItunesResult(resultCount: 0) }
                return ItunesResult(resultCount: result.resultCount, results: pages[page])
            }
            .assign(to: \.result, on: self)
            .store(in: &cancellables)
    }
}

