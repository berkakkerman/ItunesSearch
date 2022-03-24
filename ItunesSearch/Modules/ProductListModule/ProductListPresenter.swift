//
//  ProductListPresenter.swift
//  ItunesSearch
//
//  Created by Berk Akkerman on 23.03.2022.
//

import SwiftUI
import Combine

class ProductListPresenter: ObservableObject {
    
    private let interactor: ProductListInteractor
    private let router = ProductListRouter()
    
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: Properties
    @Published var listData: [ItunesProduct] = []
    
    // MARK: Inputs
    @Published var searchTerm: String = Constants.Default.searchTerm
    @Published var selectedFilterType: ItunesMediaKind =  Constants.Default.productKind
    
    // MARK: Loading
    @Published var isLoadingPage: Bool = false
    
    private var currentPage = 0
    
    init(interactor: ProductListInteractor) {
        self.interactor = interactor
        
        interactor.$isLoadingPage
            .assign(to: \.isLoadingPage, on: self)
            .store(in: &cancellables)
        
        interactor.$listData
            .assign(to: \.listData, on: self)
            .store(in: &cancellables)
        
        interactor.observeInputs(searchTerm: $searchTerm, selectedKind: $selectedFilterType)
    }
}

// MARK: - Action
extension ProductListPresenter {
    
    func loadMoreProductsIfNeeded(product: ItunesProduct) {
        interactor.loadMoreProductsIfNeeded(currentItem: product)
    }
}

// MARK: - Navigation
extension ProductListPresenter {
    
    func makeDetailView<Content: View>(for product: ItunesProduct,
                                    @ViewBuilder content: () -> Content) -> some View {
        NavigationLink(destination: router.makeDetailView(for: product)) {
            content()
        }
    }
}
