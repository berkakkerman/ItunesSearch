//
//  ProductDetailEntity.swift
//  ItunesSearch
//
//  Created by Berk Akkerman on 23.03.2022.
//

import Combine

final class ProductDetailEntity: ObservableObject {
    
    @Published var product: ItunesProduct
    
    init(product: ItunesProduct) {
        self.product = product
    }
}
