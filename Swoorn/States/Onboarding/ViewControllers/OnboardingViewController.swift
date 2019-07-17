//
//  OnboardingViewController.swift
//  Swoorn
//
//  Created by Peter IJlst | The Mobile Company on 01/07/2019.
//  Copyright © 2019 Peter IJlst. All rights reserved.
//

import UIKit
import SwiftPin

class OnboardingViewController: UIViewController {

    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var pinView: PinView! {
        didSet {
            pinView.delegate = self
        }
    }

    var router: OnboardingRouterProtocol!
    private var pinOne: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

// MARK: - PinViewConfigurationProvider Conformance

extension OnboardingViewController: PinViewConfigurationProvider {
    var pinOutputViewConfiguration: PinOutputViewConfiguration {
        return PinOutputViewConfiguration.standard
    }

    var pinInputViewConfiguration: PinInputViewConfiguration {
        return PinInputViewConfiguration(
        layout: [
            [.one, .two, .three],
            [.four, .five, .six],
            [.seven, .eight, .nine],
            [.empty, .zero, .empty]
        ]) { button, _ in
            button.backgroundColor = .white
            button.setTitleColor(.black, for: .normal)
        }
    }
}

// MARK: - PinViewDelegate Conformance

extension OnboardingViewController: PinViewDelegate {
    var clearInputOnCompleted: Bool { return true }

    func handle(_ event: PinEvent) {
        switch event {
        case .inputCompleted(let digits):
            if !pinOne.isEmpty {
                router.completedPinSetup()
            } else {
                pinOne = digits
                    .compactMap { String($0) }
                    .joined()
                messageLabel.text = "Please confirm the PIN5 again"
            }
        default: break
        }
    }
}
