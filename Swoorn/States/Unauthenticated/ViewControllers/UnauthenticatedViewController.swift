//
//  UnauthenticatedViewController.swift
//  Swoorn
//
//  Created by Peter IJlst | The Mobile Company on 06/05/2019.
//  Copyright © 2019 Peter IJlst. All rights reserved.
//

import UIKit

class UnauthenticatedViewController: UIViewController {

    var router: UnauthenticatedRouterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    @IBAction func authPressed(_ sender: Any) {
        router.login(presentingViewController != nil)
    }
}
