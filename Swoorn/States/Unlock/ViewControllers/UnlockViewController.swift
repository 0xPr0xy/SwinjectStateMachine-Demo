//
//  UnlockViewController.swift
//  Swoorn
//
//  Created by Peter IJlst | The Mobile Company on 01/07/2019.
//  Copyright © 2019 Peter IJlst. All rights reserved.
//

import UIKit
import SwiftPin

class UnlockViewController: UIViewController {

    @IBOutlet weak var pinView: PinView! {
        didSet {
            pinView.delegate = self
        }
    }

    var router: UnlockRouterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

// MARK: - PinViewConfigurationProvider Conformance

extension UnlockViewController: PinViewConfigurationProvider {
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

extension UnlockViewController: PinViewDelegate {

    var clearInputOnCompleted: Bool { return false }

    func handle(_ event: PinEvent) {

        switch event {
        case .inputCompleted:
            router.unlock()
        default: break
        }
    }
}
