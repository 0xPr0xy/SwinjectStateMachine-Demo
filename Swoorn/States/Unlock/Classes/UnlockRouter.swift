//
//  UnlockRouter.swift
//  Swoorn
//
//  Created by Peter IJlst | The Mobile Company on 01/07/2019.
//  Copyright © 2019 Peter IJlst. All rights reserved.
//

//sourcery: AutoMockable
protocol UnlockRouterProtocol {
    func unlock()
}

class UnlockRouter: UnlockRouterProtocol {
    func unlock() {
        MyApp.shared.process(.UNLOCK)
    }
}
