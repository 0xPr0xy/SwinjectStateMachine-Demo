//
//  AuthenticatedViewController.swift
//  Swoorn
//
//  Created by Peter IJlst | The Mobile Company on 06/05/2019.
//  Copyright © 2019 Peter IJlst. All rights reserved.
//

import UIKit

class AuthenticatedViewController: UIViewController {

    var router: AuthenticatedRouterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    @IBAction func logoutPressed(_ sender: Any) {
        router.logout()
    }

    @IBAction func resetPressed(_ sender: Any) {
        router.reset()
    }
}
