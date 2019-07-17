//
//  AppAssembly.swift
//  Swoorn
//

import Swinject
import SwinjectStateMachine

class AppAssembly: Assembly {

    private enum NamedResolving {
        static let launchRules = "launch"
    }

    func assemble(container: Container) {
        container
            .autoregister(AnalyticsProtocol.self, initializer: AnalyticsEngine.init)
            .inObjectScope(.container)
        container
            .register(SystemVersionString.self) { _ in AppConfig.values.systemVersion }
        container
            .autoregister(OSVersionRule.self, initializer: OSVersionRule.init)
            .inObjectScope(.container)
        container
            .register([Rule].self, name: NamedResolving.launchRules) { resolver in
                let osVersionRule = resolver.resolve(OSVersionRule.self)!
                return [osVersionRule]
            }
            .inObjectScope(.container)
        container
            .register(MyStateMachineProtocol.self) { resolver in
                let machine = MyStateMachine(initialState: .INITIAL, container: container)
                let launchRules = resolver.resolve([Rule].self, name: NamedResolving.launchRules)
                let transitions: [Transition<State, Event>] = [
                    Transition(event: .LAUNCH, source: .INITIAL, destination: .LAUNCHED,
                               rules: launchRules),
                    Transition(event: .RESUMETOUR, source: .LAUNCHED, destination: .TOUR),
                    Transition(event: .RESUMEONBOARDING, source: .LAUNCHED, destination: .ONBOARDING),
                    Transition(event: .RESUMELOGIN, source: .LAUNCHED, destination: .LOGIN),
                    Transition(event: .RESUMEAUTHENTICATED, source: .LAUNCHED, destination: .LOCKED),
                    Transition(event: .TOURFINISHED, source: .TOUR, destination: .ONBOARDING),
                    Transition(event: .ONBOARD, source: .ONBOARDING, destination: .LOGIN),
                    Transition(event: .LOGIN, source: .LOGIN, destination: .AUTHENTICATED),
                    Transition(event: .LOGINMODAL, source: .LOGIN, destination: .AUTHENTICATED),
                    Transition(event: .LOGOUT, source: .AUTHENTICATED, destination: .LOGIN),
                    Transition(event: .EXPIREDLOGIN, source: .AUTHENTICATED, destination: .LOGIN),
                    Transition(event: .RESET, source: .AUTHENTICATED, destination: .TOUR),
                    Transition(event: .UNLOCK, source: .LOCKED, destination: .AUTHENTICATED),
                    Transition(event: .BACKGROUND, source: .AUTHENTICATED, destination: .LOCKED)
                ]
                transitions.forEach { machine.add(transition: $0) }
                return machine
            }
            .inObjectScope(.container)
    }
}
