//
//  AlertFactory.swift
//  Swoorn
//

import UIKit

class AlertFactory: AlertFactoryProtocol {

    func createWithoutActions(title: String, message: String) -> UIAlertController {
        return UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
    }
}
