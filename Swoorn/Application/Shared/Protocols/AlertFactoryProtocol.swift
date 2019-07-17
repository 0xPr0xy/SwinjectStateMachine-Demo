//
//  AlertFactoryProtocol.swift
//  Swoorn
//

import UIKit

//sourcery: AutoMockable
protocol AlertFactoryProtocol {
    func createWithoutActions(title: String, message: String) -> UIAlertController
}
