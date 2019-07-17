//
//  AlertFactoryTests.swift
//  SwoornTests
//
//  Created by Peter IJlst | The Mobile Company on 10/07/2019.
//  Copyright © 2019 Peter IJlst. All rights reserved.
//

import SwiftyMocky
import XCTest
import Nimble

@testable import Swoorn

class AlertFactoryTests: XCTestCase {

    let alertFactory = AlertFactory()

    func testCreateAlertWithoutActions() {
        let expectedTitle = "title"
        let expectedMessage = "message"
        let expectedStyle: UIAlertController.Style = .alert

        let alert = alertFactory.createWithoutActions(
            title: expectedTitle,
            message: expectedMessage
        )

        expect(alert).toNot(beNil())
        expect(alert.title).to(equal(expectedTitle))
        expect(alert.message).to(equal(expectedMessage))
        expect(alert.preferredStyle).to(equal(expectedStyle))
        expect(alert.actions).to(beEmpty())
    }
}
