//
//  MyApp.swift
//  Swoorn
//
//  Created by Peter IJlst | The Mobile Company on 06/05/2019.
//  Copyright © 2019 Peter IJlst. All rights reserved.
//

import Swinject
import SwinjectStateMachine
import Firebase

// MARK: - Protocol

//sourcery: AutoMockable
protocol AppProtocol {
    func process(_ stateEvent: Event)
    func log(_ analyticsEvent: EventProtocol)
    func saveState()
}

// MARK: - MyApp

class MyApp {

    static let shared = MyApp()

    private var analytics: AnalyticsProtocol!
    private var stateMachine: MyStateMachineProtocol!
    private var assembler: Assembler!

    private init() {
        guard FirebaseApp.app() == nil else { return }
        FirebaseApp.configure()
    }

    func assembleDependencies(_ assemblies: [Assembly]) {
        assembler = Assembler(assemblies)
    }

    func inject(_ stateMachine: MyStateMachineProtocol) {
        self.stateMachine = stateMachine
    }

    func inject(_ analytics: AnalyticsProtocol) {
        self.analytics = analytics
    }
}

// MARK: - AppProtocol Conformance

extension MyApp: AppProtocol {

    func log(_ analyticsEvent: EventProtocol) {
        analytics.log(analyticsEvent)
    }

    func process(_ stateEvent: Event) {
        if stateEvent == .RESET {
            stateMachine.clearStateStorage()
        }

        stateMachine?.process(event: stateEvent) { transitionResult in
            guard stateEvent == .LAUNCH, transitionResult == .success else { return }
            switch self.stateMachine.restoredState ?? .TOUR {
            case .AUTHENTICATED:    self.process(.RESUMEAUTHENTICATED)
            case .LOGIN:            self.process(.RESUMELOGIN)
            case .ONBOARDING:       self.process(.RESUMEONBOARDING)
            default:                self.process(.RESUMETOUR)
            }
        }
    }

    func saveState() {
        stateMachine.storeCurrentState()
    }
}
