//
//  OnboardingDependencies.swift
//  Swoorn
//
//  Created by Peter IJlst | The Mobile Company on 01/07/2019.
//  Copyright © 2019 Peter IJlst. All rights reserved.
//

import Swinject

struct OnboardingDependencies: Assembly {

    func assemble(container: Container) {
        container
            .autoregister(OnboardingRouterProtocol.self, initializer: OnboardingRouter.init)
            .inObjectScope(.container)
        container
            .storyboardInitCompleted(OnboardingViewController.self) { resolver, viewController in
                let router = resolver.resolve(OnboardingRouterProtocol.self)!
                viewController.router = router
            }
    }
}
