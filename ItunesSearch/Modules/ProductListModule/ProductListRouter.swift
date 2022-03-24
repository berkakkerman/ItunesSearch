//
//  ProductListRouter.swift
//  ItunesSearch
//
//  Created by Berk Akkerman on 23.03.2022.
//

import SwiftUI

class ProductListRouter {
    
    func makeDetailView(for product: ItunesProduct) -> some View {
        return DIContainer.shared.resolve(type: ProductDetailView.self, arguments: product)
    }
}
