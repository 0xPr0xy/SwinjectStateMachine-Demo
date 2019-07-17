//
//  OnboardingRouter.swift
//  Swoorn
//
//  Created by Peter IJlst | The Mobile Company on 01/07/2019.
//  Copyright © 2019 Peter IJlst. All rights reserved.
//

import Foundation

//sourcery: AutoMockable
protocol OnboardingRouterProtocol {
    func completedPinSetup()
}

class OnboardingRouter: OnboardingRouterProtocol {

    func completedPinSetup() {
        MyApp.shared.process(.ONBOARD)
    }
}
