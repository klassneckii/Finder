//
//  RequestBuilderAssembly.swift
//  Finder
//
//  Created by Dmitry Parzhetsky on 20/03/2017.
//  Copyright © 2017 klassneckii prod. All rights reserved.
//

import Foundation
import Dip

/**
 Request builder assembly.
 */
class RequestBuilderAssembly: DipAssembly {
    static func moduleContainer(collaboratingAssemblies: [DependencyContainer]?) -> DependencyContainer {
        let container = DependencyContainer()
        
        if let collaboratingAssemblies = collaboratingAssemblies {
            container.collaborate(with: collaboratingAssemblies)
        }
        
        container.register { URLBuilderImplementation() as URLBuilder }
        
        container.register {
            try RequestBuilderImplementation(urlBuilder: container.resolve()) }
            .implements(RequestBuilder.self)
        
        return container
    }
}
