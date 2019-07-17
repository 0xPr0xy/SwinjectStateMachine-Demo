//
//  OSVersionRuleTests.swift
//  SwoornTests
//
//  Created by Peter IJlst | The Mobile Company on 10/07/2019.
//  Copyright © 2019 Peter IJlst. All rights reserved.
//

import SwiftyMocky
import XCTest
import Nimble

@testable import Swoorn

class OSVersionRuleTests: XCTestCase {

    let alertFactory = AlertFactoryProtocolMock()
    let blockedOS = "12.0"
    let nonBlockedOS = "13.0"

    func testRuleFails() {
        alertFactory.given(.createWithoutActions(title: .any, message: .any, willReturn: UIAlertController()))

        let rule = OSVersionRule(alertFactory: alertFactory, systemVersion: blockedOS)

        expect(rule.isAllowedToFail).to(beFalse())
        expect(rule.onFailure).toNot(beNil())
        expect(rule.passes).to(beFalse())

        rule.onFailure!()

        alertFactory.verify(.createWithoutActions(title: .any, message: .any), count: 1)
    }

    func testRuleSucceeds() {
        alertFactory.given(.createWithoutActions(title: .any, message: .any, willReturn: UIAlertController()))

        let rule = OSVersionRule(alertFactory: alertFactory, systemVersion: nonBlockedOS)

        expect(rule.isAllowedToFail).to(beFalse())
        expect(rule.onFailure).toNot(beNil())
        expect(rule.passes).to(beTrue())

        alertFactory.verify(.createWithoutActions(title: .any, message: .any), count: 0)
    }
}
