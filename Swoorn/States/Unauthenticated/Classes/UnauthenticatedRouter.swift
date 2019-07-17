//
//  UnauthenticatedRouter.swift
//  Swoorn
//
//  Created by Peter IJlst | The Mobile Company on 09/07/2019.
//  Copyright © 2019 Peter IJlst. All rights reserved.
//

//sourcery: AutoMockable
protocol UnauthenticatedRouterProtocol {
    func login(_ isPresentedModally: Bool)
}

class UnauthenticatedRouter: UnauthenticatedRouterProtocol {
    func login(_ isPresentedModally: Bool) {
        MyApp.shared.process(isPresentedModally ? .LOGINMODAL : .LOGIN)
    }
}
