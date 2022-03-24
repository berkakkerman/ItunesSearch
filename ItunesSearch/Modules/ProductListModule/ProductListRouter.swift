//
//  ProductListRouter.swift
//  ItunesSearch
//
//  Created by Berk Akkerman on 23.03.2022.
//

import SwiftUI

class ProductListRouter {
    
    func makeDetailView(for product: ItunesProduct) -> some View {
        let entity = ProductDetailEntity(product: product)
        let interactor = ProductDetailInteractor(model: entity)
        let presenter = ProductDetailPresenter(interactor: interactor)
        return ProductDetailView(presenter: presenter)
    }
}
