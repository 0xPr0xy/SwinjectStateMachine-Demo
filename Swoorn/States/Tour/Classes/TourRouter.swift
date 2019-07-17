//
//  TourRouter.swift
//  Swoorn
//
//  Created by Peter IJlst | The Mobile Company on 09/07/2019.
//  Copyright © 2019 Peter IJlst. All rights reserved.
//

//sourcery: AutoMockable
protocol TourRouterProtocol {
    func finish()
}

class TourRouter: TourRouterProtocol {
    func finish() {
        MyApp.shared.process(.TOURFINISHED)
    }
}
