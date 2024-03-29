//
//  DIContainer.swift
//  ItunesSearch
//
//  Created by Berk Akkerman on 22.03.2022.
//

import Foundation

protocol DIContainerProtocol {
    func register<Component>(type: Component.Type, scope: DIScope, component: @escaping (Any?) -> Component)
    func resolve<Component>(type: Component.Type, arguments: Any?) -> Component?
    func reset(scope: DIScope?)
}

extension DIContainerProtocol {
    
    func register<Component>(type: Component.Type, scope: DIScope = .singleton, component: @escaping (Any?) -> Component) {
        register(type: type, scope: scope, component: component)
    }
    
    func resolve<Component>(type: Component.Type, arguments: Any? = nil) -> Component?  {
        return resolve(type: type, arguments: arguments)
    }
    
    func reset(scope: DIScope? = nil) {
        reset(scope: scope)
    }
}

final class DIContainer: DIContainerProtocol {
    
    static let shared = DIContainer()
    var components: [String: DIComponent] = [:]
    
    private init() {}
    
    func register<Component>(type: Component.Type,
                             scope: DIScope = .singleton,
                             component: @escaping (Any?) -> Component) {
        components["\(type)"] = DIComponent(scope: scope, resolver: component)
    }
    
    func resolve<Component>(type: Component.Type,
                            arguments: Any? = nil) -> Component? {
        return components["\(type)"]?.resolve(arguments: arguments) as? Component
    }
    
    func reset(scope: DIScope? = nil) {
        let resetList: [String: DIComponent] = {
            guard let scope = scope else { return components }
            return components.filter { $0.value.scope == scope }
        }()
        
        resetList.forEach { (_, value) in
            value.reset()
        }
    }
}
