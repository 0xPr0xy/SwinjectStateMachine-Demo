//
//  NetworkLogoutViewController.swift
//  Swoorn
//
//  Created by Peter IJlst | The Mobile Company on 02/07/2019.
//  Copyright © 2019 Peter IJlst. All rights reserved.
//

import UIKit

class NetworkLogoutViewController: UIViewController {

    var router: AuthenticatedRouterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    @IBAction func networkLogoutPressed(_ sender: Any) {
        router.networkLogout()
    }
}
