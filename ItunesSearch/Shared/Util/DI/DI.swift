//
//  DI.swift
//  ItunesSearch
//
//  Created by Berk Akkerman on 22.03.2022.
//

import Foundation

final class DI {
    
    static func setupDI() {
        
        // MARK: - Network
        DIContainer.shared.register(type: NetworkSessionProtocol.self, scope: .singleton) { _ in
            NetworkSession()
        }
        
        DIContainer.shared.register(type: NetworkingProtocol.self, scope: .singleton) { _ in
            Networking(networkSession: DIContainer.shared.resolve(type: NetworkSessionProtocol.self)!)
        }
        
        DIContainer.shared.register(type: ItunesServiceProtocol.self, scope: .singleton) { _ in
            ItunesService(networking: DIContainer.shared.resolve(type: NetworkingProtocol.self)!)
        }
        
        // MARK: - Product List
        DIContainer.shared.register(type: ProductListView.self, scope: .transient) { argument in
            let presenter = DIContainer.shared.resolve(type: ProductListPresenter.self, arguments: argument)!
            return ProductListView(presenter: presenter)
        }
        
        DIContainer.shared.register(type: ProductListRouter.self, scope: .transient) { _ in
            return ProductListRouter()
        }
        
        DIContainer.shared.register(type: ProductListPresenter.self, scope: .transient) { argument in
            let interactor = DIContainer.shared.resolve(type: ProductListInteractor.self, arguments: argument)!
            let router = DIContainer.shared.resolve(type: ProductListRouter.self)!
            return ProductListPresenter(interactor: interactor, router: router)
        }
        
        DIContainer.shared.register(type: ProductListInteractor.self, scope: .transient) { argument in
            let entity = DIContainer.shared.resolve(type: ProductListEntity.self, arguments: argument)!
            return ProductListInteractor(model: entity)
        }
        
        DIContainer.shared.register(type: ProductListEntity.self, scope: .transient) { _ in
            let provider = DIContainer.shared.resolve(type: ItunesServiceProtocol.self)!
            return ProductListEntity(provider: provider)
        }
        
        
        // MARK: - Product Detail
        DIContainer.shared.register(type: ProductDetailView.self, scope: .transient) { argument in
            let presenter = DIContainer.shared.resolve(type: ProductDetailPresenter.self, arguments: argument)!
            return ProductDetailView(presenter: presenter)
        }
        
        DIContainer.shared.register(type: ProductDetailRouter.self, scope: .transient) { _ in
            return ProductDetailRouter()
        }
        
        DIContainer.shared.register(type: ProductDetailPresenter.self, scope: .transient) { argument in
            let interactor = DIContainer.shared.resolve(type: ProductDetailInteractor.self, arguments: argument)!
            let router = DIContainer.shared.resolve(type: ProductDetailRouter.self)!
            return ProductDetailPresenter(interactor: interactor, router: router)
        }
        
        DIContainer.shared.register(type: ProductDetailInteractor.self, scope: .transient) { argument in
            let entity = DIContainer.shared.resolve(type: ProductDetailEntity.self, arguments: argument)!
            return ProductDetailInteractor(model: entity)
        }
        
        DIContainer.shared.register(type: ProductDetailEntity.self, scope: .transient) { argument in
            let entity = ProductDetailEntity(product: argument as! ItunesProduct)
            return entity
        }
    }
    
    func resetDI() {
        DIContainer.shared.reset()
    }
}
