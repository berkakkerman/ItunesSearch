//
//  ProductListModuleTests.swift
//  ItunesSearchTests
//
//  Created by Berk Akkerman on 24.03.2022.
//

import XCTest
@testable import ItunesSearch

class ProductListModuleTests: XCTestCase {
    
    override class func setUp() {       
        Self.setupAssemblies()
    }
    
    func testProductListView() {
        XCTAssertNotNil(DIContainer.shared.resolve(type: ProductListView.self))
    }
    
    func testProductListRouter() {
        XCTAssertNotNil(DIContainer.shared.resolve(type: ProductListRouter.self))
    }
    
    func testProductListPresenter() {
        XCTAssertNotNil(DIContainer.shared.resolve(type: ProductListPresenter.self))
    }
    
    func testProductListInteractorTest() {
        XCTAssertNotNil(DIContainer.shared.resolve(type: ProductListInteractor.self))
    }
    
    func testProductEntityTest() {
        XCTAssertNotNil(DIContainer.shared.resolve(type: ProductListEntity.self))
    }
}

// MARK: - Setup Asssemblies
extension ProductListModuleTests {
    
    class func setupAssemblies() {
        DIContainer.shared.reset()
        
        // MARK: - Product Detail
        DIContainer.shared.register(type: ProductListView.self, scope: .singleton) { argument in
            let presenter = DIContainer.shared.resolve(type: ProductListPresenter.self, arguments: argument)!
            return ProductListView(presenter: presenter)
        }
        
        DIContainer.shared.register(type: ProductListRouter.self, scope: .singleton) { _ in
            return ProductListRouter()
        }
        
        DIContainer.shared.register(type: ProductListPresenter.self, scope: .singleton) { argument in
            let interactor = DIContainer.shared.resolve(type: ProductListInteractor.self, arguments: argument)!
            let router = DIContainer.shared.resolve(type: ProductListRouter.self)!
            return ProductListPresenter(interactor: interactor, router: router)
        }
        
        DIContainer.shared.register(type: ProductListInteractor.self, scope: .singleton) { argument in
            let entity = DIContainer.shared.resolve(type: ProductListEntity.self, arguments: argument)!
            return ProductListInteractor(model: entity)
        }
        
        DIContainer.shared.register(type: ProductListEntity.self, scope: .singleton) { _ in
            let entity = ProductListEntity(provider: FakeItunesService())
            return entity
        }
    }
}
