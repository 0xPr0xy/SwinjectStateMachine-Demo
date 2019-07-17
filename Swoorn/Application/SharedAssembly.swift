//
//  SharedAssembly.swift
//  Swoorn
//

import Swinject
import SwinjectStateMachine

class SharedAssembly: Assembly {

    func loaded(resolver: Resolver) {
        let stateMachine = resolver.resolve(MyStateMachineProtocol.self)!
        MyApp.shared.inject(stateMachine)

        let analytics = resolver.resolve(AnalyticsProtocol.self)!
        MyApp.shared.inject(analytics)
    }

    func assemble(container: Container) {
        container
            .autoregister(AlertFactoryProtocol.self, initializer: AlertFactory.init)
            .inObjectScope(.container)
    }
}
