//
//  DipAssembly.swift
//  Finder
//
//  Created by Dmitrii on 18.03.17.
//  Copyright © 2017 klassneckii prod. All rights reserved.
//

import Foundation
import Dip

protocol DipAssembly {
    static func moduleContainer() -> DependencyContainer
    static func moduleContainer(collaboratingAssemblies: [DependencyContainer]?) -> DependencyContainer
}

extension DipAssembly {
    static func moduleContainer() -> DependencyContainer {
        return moduleContainer(collaboratingAssemblies: nil)
    }
}
