//
//  DI.swift
//  ItunesSearch
//
//  Created by Berk Akkerman on 22.03.2022.
//

import Foundation

final class DI {
    
    static func setupDI() {
        DIContainer.shared.register(type: NetworkSessionProtocol.self, scope: .singleton) { _ in
            NetworkSession()
        }
        
        DIContainer.shared.register(type: NetworkingProtocol.self, scope: .singleton) { _ in
            Networking(networkSession: DIContainer.shared.resolve(type: NetworkSessionProtocol.self)!)
        }
        
        DIContainer.shared.register(type: ItunesServiceProtocol.self, scope: .transient) { _ in
            ItunesService(networking: DIContainer.shared.resolve(type: NetworkingProtocol.self)!)
        }
        
        /*
         DIContainer.shared.register(type: View.self, scope: .transient) { argument in
         let vm = WebViewVM(paylinkRepository: DIContainer.shared.resolve(type: Protocol.self)!,
         model: argument as! Model)
         return vm
         }
         */
    }
    
    func resetDI() {
        DIContainer.shared.reset()
    }
}
