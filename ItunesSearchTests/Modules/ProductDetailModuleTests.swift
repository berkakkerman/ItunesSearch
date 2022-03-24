//
//  ProductDetailModuleTests.swift
//  ItunesSearchTests
//
//  Created by Berk Akkerman on 24.03.2022.
//

import XCTest
@testable import ItunesSearch

class ProductDetailModuleTests: XCTestCase {
    
    override class func setUp() {
        Self.setupAssemblies()
    }
    
    func testProductDetailView() {
        XCTAssertNotNil(DIContainer.shared.resolve(type: ProductDetailView.self))
    }
    
    func testProductDetailRouter() {
        XCTAssertNotNil(DIContainer.shared.resolve(type: ProductDetailRouter.self))
    }
    
    func testProductDetailPresenter() {
        XCTAssertNotNil(DIContainer.shared.resolve(type: ProductDetailPresenter.self))
    }
    
    func testProductDetailInteractorTest() {
        XCTAssertNotNil(DIContainer.shared.resolve(type: ProductDetailInteractor.self))
    }
    
    func testProductEntityTest() {
        XCTAssertNotNil(DIContainer.shared.resolve(type: ProductDetailEntity.self))
    }
}

// MARK: - Setup Asssemblies
extension ProductDetailModuleTests {

    class func setupAssemblies() {
        DIContainer.shared.reset()
        
        // MARK: - Product Detail
        DIContainer.shared.register(type: ProductDetailView.self, scope: .singleton) { argument in
            let presenter = DIContainer.shared.resolve(type: ProductDetailPresenter.self, arguments: argument)!
            return ProductDetailView(presenter: presenter)
        }
        
        DIContainer.shared.register(type: ProductDetailRouter.self, scope: .singleton) { _ in
            return ProductDetailRouter()
        }
        
        DIContainer.shared.register(type: ProductDetailPresenter.self, scope: .singleton) { argument in
            let interactor = DIContainer.shared.resolve(type: ProductDetailInteractor.self, arguments: argument)!
            let router = DIContainer.shared.resolve(type: ProductDetailRouter.self)!
            return ProductDetailPresenter(interactor: interactor, router: router)
        }
        
        DIContainer.shared.register(type: ProductDetailInteractor.self, scope: .singleton) { argument in
            let entity = DIContainer.shared.resolve(type: ProductDetailEntity.self, arguments: argument)!
            return ProductDetailInteractor(model: entity)
        }
        
        DIContainer.shared.register(type: ProductDetailEntity.self, scope: .singleton) { _ in
            let entity = ProductDetailEntity(product: ItunesProduct.previewValue)
            return entity
        }
    }
}
