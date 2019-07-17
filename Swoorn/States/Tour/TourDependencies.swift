//
//  TourDependencies.swift
//  Swoorn
//
//  Created by Peter IJlst | The Mobile Company on 09/07/2019.
//  Copyright © 2019 Peter IJlst. All rights reserved.
//

import Swinject

struct TourDependencies: Assembly {

    func assemble(container: Container) {
        container
            .autoregister(TourRouterProtocol.self, initializer: TourRouter.init)
            .inObjectScope(.container)
        container
            .storyboardInitCompleted(EndTourViewController.self) { resolver, viewController in
                let router = resolver.resolve(TourRouterProtocol.self)!
                viewController.router = router
        }
    }
}
