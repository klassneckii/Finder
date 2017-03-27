//
//  GithubAssembly.swift
//  Finder
//
//  Created by Dmitry Parzehtsky on 26/03/2017.
//  Copyright © 2017 kl prod. All rights reserved.
//

import Dip
import Dip_UI

let GithubViewControllerIdentifier = "GithubViewController"

class GithubAssembly: DipAssembly {
    static func moduleContainer(collaboratingAssemblies: [DependencyContainer]?) -> DependencyContainer {
        
        let container = DependencyContainer()
        
        container.register(tag: GithubViewControllerIdentifier) { GithubViewController() }
            .resolvingProperties{ container, controller in
                controller.output = try container.resolve() as GithubPresenter
                controller.dataDisplayManager = try container.resolve() as GithubDataDisplayManagerImplementation
                controller.animator = try container.resolve() as CoverImageViewAnimator
        }
        
        container.register { GithubCellViewModelFactoryImplementation() }
            .implements(GithubCellViewModelFactory.self)
        
        container.register { ImageCacheLoader() }
            .resolvingProperties { container, loader in
                loader.session = URLSession.shared
                loader.task = URLSessionDownloadTask()
                loader.cache = NSCache()
        }
        
        container.register { CoverImageViewAnimator() }
        
        container.register { GithubDataDisplayManagerImplementation() }
            .resolvingProperties{ container, dataDisplayManager in
                dataDisplayManager.factory = try container.resolve() as GithubCellViewModelFactoryImplementation
                dataDisplayManager.imageLoader = try container.resolve() as ImageCacheLoader
            }.implements(GithubDataDisplayManager.self)
        
        container.register { GithubRouter() }
            .resolvingProperties { container, router in
                router.transitionHandler = try container.resolve(tag: GithubViewControllerIdentifier) as GithubViewController
        }

        container.register { GithubInteractor() }
            .resolvingProperties { container, interactor in
                interactor.output = try container.resolve() as GithubPresenter
                interactor.githubService = try container.resolve() as GithubService
        }

        container.register { GithubPresenter() }
            .resolvingProperties{ container, presenter in
                presenter.view = try container.resolve(tag: GithubViewControllerIdentifier) as GithubViewController
                presenter.router = try container.resolve() as GithubRouter
                presenter.interactor = try container.resolve() as GithubInteractor
        }
        
        if let collaboratingAssemblies = collaboratingAssemblies {
            container.collaborate(with: collaboratingAssemblies)
        }

        DependencyContainer.uiContainers.append(container)
        return container
    }
}
