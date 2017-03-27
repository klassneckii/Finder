//
//  ServiceAssembly.swift
//  Finder
//
//  Created by Dmitry Parzhetsky on 20/03/2017.
//  Copyright © 2017 klassneckii prod. All rights reserved.
//

import Foundation
import Dip

/**
 Services assembly
 */
class ServicesAssembly: DipAssembly {
    
    static func moduleContainer(collaboratingAssemblies: [DependencyContainer]?) -> DependencyContainer {
        let container = DependencyContainer()
        
        if let collaboratingAssemblies = collaboratingAssemblies {
            container.collaborate(with: collaboratingAssemblies)
        }
        
        container.register { ITunesServiceImplementation(requestBuilder: $0,
                                                         networkClient: $1,
                                                         deserializer: $2,
                                                         mapper: $3) }
            .implements(ITunesService.self)
        
        container.register { GithubServiceImplementation(requestBuilder: $0,
                                                         networkClient: $1,
                                                         deserializer: $2,
                                                         mapper: $3) }
            .implements(GithubService.self)

        return container
    }
}
