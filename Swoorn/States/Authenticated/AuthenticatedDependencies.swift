//
//  AuthenticatedDependencies.swift
//  Swoorn
//
//  Created by Peter IJlst | The Mobile Company on 06/05/2019.
//  Copyright © 2019 Peter IJlst. All rights reserved.
//

import Swinject
import Firebase

struct AuthenticatedDependencies: Assembly {

    func assemble(container: Container) {
        container
            .autoregister(AuthenticatedRouterProtocol.self, initializer: AuthenticatedRouter.init)
            .inObjectScope(.container)
        container
            .storyboardInitCompleted(AuthenticatedViewController.self) { resolver, viewController in
                let router = resolver.resolve(AuthenticatedRouterProtocol.self)!
                viewController.router = router
            }
        container
            .storyboardInitCompleted(NetworkLogoutViewController.self) { resolver, viewController in
                let router = resolver.resolve(AuthenticatedRouterProtocol.self)!
                viewController.router = router
            }
    }
}
