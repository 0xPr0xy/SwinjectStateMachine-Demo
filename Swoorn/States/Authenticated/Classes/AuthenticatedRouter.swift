//
//  AuthenticatedRouter.swift
//  Swoorn
//
//  Created by Peter IJlst | The Mobile Company on 08/05/2019.
//  Copyright © 2019 Peter IJlst. All rights reserved.
//

import Foundation

//sourcery: AutoMockable
protocol AuthenticatedRouterProtocol {
    func logout()
    func reset()
    func networkLogout()
}

class AuthenticatedRouter: AuthenticatedRouterProtocol {

    func logout() {
        MyApp.shared.process(.LOGOUT)
    }

    func reset() {
        MyApp.shared.process(.RESET)
    }

    func networkLogout() {
        MyApp.shared.process(.EXPIREDLOGIN)
    }
}
