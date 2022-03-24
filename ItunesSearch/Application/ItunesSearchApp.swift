//
//  ItunesSearchApp.swift
//  ItunesSearch
//
//  Created by Berk Akkerman on 18.03.2022.
//

import SwiftUI

@main
struct ItunesSearchApp: App {
    
    init() {
        DI.setupDI()
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                let entity = ProductListEntity()
                let interactor = ProductListInteractor(model: entity)
                let presenter = ProductListPresenter(interactor: interactor)
                ProductListView(presenter: presenter)
            }
        }
    }
}
