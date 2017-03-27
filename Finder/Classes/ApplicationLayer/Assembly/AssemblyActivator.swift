//
//  AssemblyActivator.swift
//  Finder
//
//  Created by Dmitrii on 19.03.17.
//  Copyright © 2017 klassneckii prod. All rights reserved.
//

import Foundation
import Dip

/** Project assembly activator */
class AssemblyActivator {

    private var searchResultsContainer: DependencyContainer!
    private var itunesContainer: DependencyContainer!
    private var githubContainer: DependencyContainer!
    private var servicesContainer: DependencyContainer!

    private var coreContainer: DependencyContainer!
    private var requestBuilderContainer: DependencyContainer!
    
    func activateAssemblies() {
        
        /* Core layer assemblies */
        requestBuilderContainer = RequestBuilderAssembly.moduleContainer()
        coreContainer = CoreAssembly.moduleContainer()
        
        /* Service layer assemblies */
        servicesContainer = ServicesAssembly.moduleContainer(collaboratingAssemblies: [coreContainer, requestBuilderContainer])
        
        /* Presentation layer assemblies */
        searchResultsContainer = SearchResultsAssembly.moduleContainer()
        itunesContainer = ItunesAssembly.moduleContainer(collaboratingAssemblies: [servicesContainer])
        githubContainer = GithubAssembly.moduleContainer(collaboratingAssemblies: [servicesContainer])
    }
}
