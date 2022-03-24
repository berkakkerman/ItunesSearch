//
//  DIScope.swift
//  ItunesSearch
//
//  Created by Berk Akkerman on 22.03.2022.
//

import Foundation

protocol DIScopeProtocol { }

enum DIScope: DIScopeProtocol {
    case transient
    case singleton
}
