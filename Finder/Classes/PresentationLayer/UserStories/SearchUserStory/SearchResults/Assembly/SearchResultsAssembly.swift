//
//  SearchResultsAssembly.swift
//  Finder
//
//  Created by Dmitrii on 21.03.17.
//  Copyright © 2017 klassneckii prod. All rights reserved.
//

import Foundation

import Dip
import Dip_UI

let SearchResultsViewControllerIdentifier = "SearchResultsViewController"

class SearchResultsAssembly: DipAssembly {
    static func moduleContainer(collaboratingAssemblies: [DependencyContainer]?) -> DependencyContainer {
        
        let container = DependencyContainer()
        
        if let collaboratingAssemblies = collaboratingAssemblies {
            container.collaborate(with: collaboratingAssemblies)
        }
        
        container.register(tag: SearchResultsViewControllerIdentifier) { SearchResultsViewController() }
            .resolvingProperties{ container, controller in
                controller.output = try container.resolve() as SearchResultsPresenter
        }
        
        container.register { SearchResultsRouter() }
            .resolvingProperties { container, router in
                router.transitionHandler = try container.resolve(tag: SearchResultsViewControllerIdentifier) as SearchResultsViewController
        }
        
        container.register { SearchResultsInteractor() }
            .resolvingProperties { container, interactor in
                interactor.output = try container.resolve() as SearchResultsPresenter
        }

        container.register { SearchResultsPresenter() }
            .resolvingProperties{ container, presenter in
                presenter.view = try container.resolve(tag: SearchResultsViewControllerIdentifier) as SearchResultsViewController
                presenter.router = try container.resolve() as SearchResultsRouter
                presenter.interactor = try container.resolve() as SearchResultsInteractor
        }
        
        container.register { CoverImageViewAnimator() }

        DependencyContainer.uiContainers.append(container)
        return container
    }
}
