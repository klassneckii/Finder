//
//  ItunesAssembly.swift
//  Finder
//
//  Created by Dmitry Parzehtsky on 26/03/2017.
//  Copyright © 2017 kl prod. All rights reserved.
//

import Dip
import Dip_UI

let ItunesViewControllerIdentifier = "ItunesViewController"

class ItunesAssembly: DipAssembly {
    static func moduleContainer(collaboratingAssemblies: [DependencyContainer]?) -> DependencyContainer {
        
        let container = DependencyContainer()

        container.register(tag: ItunesViewControllerIdentifier) { ItunesViewController() }
            .resolvingProperties{ container, controller in
                controller.output = try container.resolve() as ItunesPresenter
                controller.dataDisplayManager = try container.resolve() as ItunesDataDisplayManagerImplementation
                controller.animator = try container.resolve() as CoverImageViewAnimator
        }
        
        container.register { ItunesCellViewModelFactoryImplementation() }
            .implements(ItunesCellViewModelFactory.self)
        
        container.register { ImageCacheLoader() }
            .resolvingProperties { container, loader in
                loader.session = URLSession.shared
                loader.task = URLSessionDownloadTask()
                loader.cache = NSCache()
        }
        
        container.register { ItunesDataDisplayManagerImplementation() }
            .resolvingProperties{ container, dataDisplayManager in
                dataDisplayManager.factory = try container.resolve() as ItunesCellViewModelFactoryImplementation
                dataDisplayManager.imageLoader = try container.resolve() as ImageCacheLoader
        }.implements(ItunesDataDisplayManager.self)
        
        container.register { CoverImageViewAnimator() }
        
        container.register { ItunesRouter() }
            .resolvingProperties { container, router in
                router.transitionHandler = try container.resolve(tag: ItunesViewControllerIdentifier) as ItunesViewController
        }
        
        container.register { ItunesInteractor() }
            .resolvingProperties { container, interactor in
                interactor.output = try container.resolve() as ItunesPresenter
                interactor.iTunesService = try container.resolve() as ITunesService
        }
        
        container.register { ItunesPresenter() }
            .resolvingProperties{ container, presenter in
                presenter.view = try container.resolve(tag: ItunesViewControllerIdentifier) as ItunesViewController
                presenter.router = try container.resolve() as ItunesRouter
                presenter.interactor = try container.resolve() as ItunesInteractor
        }
        
        
        if let collaboratingAssemblies = collaboratingAssemblies {
            container.collaborate(with: collaboratingAssemblies)
        }

        DependencyContainer.uiContainers.append(container)
        return container
    }
}
