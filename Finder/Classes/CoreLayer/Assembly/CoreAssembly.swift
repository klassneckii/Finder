//
//  CoreAssembly.swift
//  Finder
//
//  Created by Dmitry Parzhetsky on 20/03/2017.
//  Copyright © 2017 klassneckii prod. All rights reserved.
//

import Foundation
import Dip

/** Core components assembly */

class CoreAssembly: DipAssembly {
    static func moduleContainer(collaboratingAssemblies: [DependencyContainer]?) -> DependencyContainer {
        let container = DependencyContainer()
        
        if let collaboratingAssemblies = collaboratingAssemblies {
            container.collaborate(with: collaboratingAssemblies)
        }
        
        container.register { JSONDeserializer() }.implements(Deserializer.self)
        container.register { NetworkClientImplementation(session: URLSession.shared) }.implements(NetworkClient.self)
        
        container.register { ITunesResponseMapper() }
        container.register { GithubResponseMapper() }
        
        return container
    }
}
