//
//  UIViewController+PresentingProtocol.swift
//  Swoorn
//
//  Created by Peter IJlst | The Mobile Company on 10/07/2019.
//  Copyright © 2019 Peter IJlst. All rights reserved.
//

import UIKit

//sourcery: AutoMockable
protocol PresentingProtocol {
    func present(_ viewControllerToPresent: UIViewController, animated flag: Bool)
}
extension UIViewController: PresentingProtocol {
    func present(_ viewControllerToPresent: UIViewController, animated flag: Bool) {
        present(viewControllerToPresent, animated: flag, completion: nil)
    }
}
