//
//  UnauthenticatedDependencies.swift
//  Swoorn
//
//  Created by Peter IJlst | The Mobile Company on 06/05/2019.
//  Copyright © 2019 Peter IJlst. All rights reserved.
//

import Swinject

struct UnauthenticatedDependencies: Assembly {

    func assemble(container: Container) {
        container
            .autoregister(UnauthenticatedRouterProtocol.self, initializer: UnauthenticatedRouter.init)
            .inObjectScope(.container)
        container
            .storyboardInitCompleted(UnauthenticatedViewController.self) { resolver, viewController in
                let router = resolver.resolve(UnauthenticatedRouterProtocol.self)!
                viewController.router = router
            }
    }
}
