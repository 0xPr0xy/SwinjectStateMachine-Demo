//
//  UnlockDependencies.swift
//  Swoorn
//
//  Created by Peter IJlst | The Mobile Company on 01/07/2019.
//  Copyright © 2019 Peter IJlst. All rights reserved.
//

import Swinject

struct UnlockDependencies: Assembly {

    func assemble(container: Container) {
        container
            .autoregister(UnlockRouterProtocol.self, initializer: UnlockRouter.init)
            .inObjectScope(.container)
        container
            .storyboardInitCompleted(UnlockViewController.self) { resolver, viewController in
                let router = resolver.resolve(UnlockRouterProtocol.self)!
                viewController.router = router
            }
    }
}
