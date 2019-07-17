//
//  EndTourViewController.swift
//  Swoorn
//
//  Created by Peter IJlst | The Mobile Company on 09/07/2019.
//  Copyright © 2019 Peter IJlst. All rights reserved.
//

import UIKit

class EndTourViewController: UIViewController {

    var router: TourRouterProtocol!

    @IBAction func finishPressed(_ sender: Any) {
        router.finish()
    }
}
