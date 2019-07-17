//
//  Router.swift
//  Swoorn
//
//  Created by Peter IJlst | The Mobile Company on 03/05/2019.
//  Copyright © 2019 Peter IJlst. All rights reserved.
//

import Swinject
import SwinjectStoryboard

class Router {

    private var storyboard: SwinjectStoryboard

    var rootViewController: UIViewController? {
        get { return UIApplication.shared.keyWindow?.rootViewController }
        set { UIApplication.shared.keyWindow?.rootViewController = newValue }
    }

    init(storyboardIdentifier: String,
         dependencyContainer: Container,
         assemblers: [Assembly] = [],
         bundle: Bundle? = nil) {

        let childContainer = Container(parent: dependencyContainer)

        assemblers.forEach { $0.assemble(container: childContainer) }

        storyboard = SwinjectStoryboard.create(name: storyboardIdentifier,
                                               bundle: bundle,
                                               container: childContainer)
    }

    open func routeToInitial() {
        present(storyboard.instantiateInitialViewController())
    }

    open func present(_ viewController: UIViewController?) {
        rootViewController = viewController
    }
}
