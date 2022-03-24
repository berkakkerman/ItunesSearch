//
//  ProductDetailInteractor.swift
//  ItunesSearch
//
//  Created by Berk Akkerman on 23.03.2022.
//

import Foundation

protocol ProductDetailInteractorProtocol: ObservableObject {
    func getProduct() -> ItunesProduct
}

class ProductDetailInteractor: ProductDetailInteractorProtocol {
    
    let model: ProductDetailEntity
    
    init (model: ProductDetailEntity) {
        self.model = model
    }
    
    func getProduct() -> ItunesProduct {
        return self.model.product
    }
}
