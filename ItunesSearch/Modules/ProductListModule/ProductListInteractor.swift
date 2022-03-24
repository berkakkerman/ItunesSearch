//
//  ProductListInteractor.swift
//  ItunesSearch
//
//  Created by Berk Akkerman on 23.03.2022.
//

import Foundation
import Combine

class ProductListInteractor {
    
    let model: ProductListEntity
    
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: Loading
    @Published var isLoadingPage: Bool = false
    
    @Published var listData: [ItunesProduct] = []    
    @Published var currentPageProducts: [ItunesProduct] = []
    @Published var searchTerm: String = Constants.Default.searchTerm
    @Published private var lastSearchTerm: String = Constants.Default.searchTerm
    @Published var selectedFilterType: ItunesMediaKind =  Constants.Default.productKind
    @Published var totalResults = 0
    private var currentPage = 0
    
    init (model: ProductListEntity) {
        self.model = model
        
        model.$result
            .map { $0.results }
            .assign(to: \.currentPageProducts, on: self)
            .store(in: &cancellables)
        
        model.$result
            .map { $0.resultCount ?? 0 }
            .assign(to: \.totalResults, on: self)
            .store(in: &cancellables)
        
        $currentPageProducts
            .sink { (_) in
                //
            } receiveValue: { [weak self] currentPageProducts in
                guard let self = self else { return }
                self.listData += currentPageProducts
                self.currentPage += 1
            }.store(in: &cancellables)
        
        model.$isLoading
            .assign(to: \.isLoadingPage, on: self)
            .store(in: &cancellables)
    }
    
    func observeInputs(searchTerm: Published<String>.Publisher,
                       selectedKind: Published<ItunesMediaKind>.Publisher) {
        
        searchTerm
            .assign(to: \.searchTerm, on: self)
            .store(in: &cancellables)
        
        selectedKind
            .assign(to: \.selectedFilterType, on: self)
            .store(in: &cancellables)
        
        Publishers
            .CombineLatest(searchTerm.debounce(for: 0.5, scheduler: DispatchQueue.main),
                           selectedKind.debounce(for: 0.5, scheduler: DispatchQueue.main))
            .map { ($0.0.trimmingCharacters(in: .whitespacesAndNewlines), $0.1) }
            .sink { (_) in
                //
            } receiveValue: { [weak self] (term, kind) in
                guard let self = self else { return }
                if term.isEmpty {
                    self.listData = []
                } else if term.count > 2  {
                    if let lastKind = self.listData.last?.kind, lastKind != kind {
                        self.resetPage()
                    }
                    if self.lastSearchTerm != term {
                        self.resetPage()
                    }
                    self.lastSearchTerm = term
                    self.loadProducts(term: term, kind: kind)
                }
            }.store(in: &cancellables)
    }
    
    func loadProducts(term: String, kind: ItunesMediaKind) {
        guard !isLoadingPage else { return }
        model.getResults(searchTerm: term, kind: kind, page: currentPage)
    }
}

// MARK: - Pagination
extension ProductListInteractor {
    
    func loadMoreProductsIfNeeded(currentItem item: ItunesProduct) {
        if let lastItem = self.listData.last, lastItem.trackId == item.trackId,
           self.totalResults > self.listData.count {
            loadProducts(term: searchTerm, kind: selectedFilterType)
        }
    }
    
    func resetPage() {
        self.currentPage = 0
        self.listData = []
    }
}
