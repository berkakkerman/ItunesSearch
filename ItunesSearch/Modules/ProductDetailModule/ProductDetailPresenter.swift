//
//  ProductDetailPresenter.swift
//  ItunesSearch
//
//  Created by Berk Akkerman on 23.03.2022.
//

import SwiftUI

class ProductDetailPresenter: ObservableObject {
    
    private let interactor: ProductDetailInteractor
    private let router: ProductDetailRouter
    
    @Published var product: ItunesProduct
    
    init(interactor: ProductDetailInteractor, router: ProductDetailRouter) {
        self.interactor = interactor
        self.router = router
        
        product = interactor.getProduct()
    }
}
