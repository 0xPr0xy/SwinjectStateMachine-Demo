//
//  MyAppTests.swift
//  SwoornTests
//
//  Created by Peter IJlst | The Mobile Company on 04/07/2019.
//  Copyright © 2019 Peter IJlst. All rights reserved.
//

import Swinject
import SwinjectStoryboard
import SwinjectStateMachine

import SwiftyMocky
import XCTest
import Nimble

@testable import Swoorn

class MyAppTests: XCTestCase {

    let stateMachine = MyStateMachineProtocolMock()
    let analytics = AnalyticsProtocolMock()
    let event = EventProtocolMock()

    override func setUp() {
        super.setUp()

        MyApp.shared.inject(stateMachine)
        MyApp.shared.inject(analytics)
    }

    func testLogEvent() {
        MyApp.shared.log(event)

        analytics.verify(.log(.any), count: 1)
    }

    func testRestoreInvocation() {
        stateMachine.given(.restoredState(getter: .LOGIN))
        stateMachine.perform(.process(
            event: .value(.LAUNCH),
            callback: .any,
            perform: { _, completion in
                completion?(.success)
            }
        ))

        MyApp.shared.process(.LAUNCH)

        stateMachine.verify(.restoredState, count: 1)
    }

    func testProcessEvent() {
        MyApp.shared.process(.LOGIN)

        stateMachine.verify(.process(event: .any, callback: .any), count: 1)
        stateMachine.verify(.restoredState, count: 0)
    }

    func testSaveState() {
        MyApp.shared.saveState()

        stateMachine.verify(.storeCurrentState(), count: 1)
    }
}
