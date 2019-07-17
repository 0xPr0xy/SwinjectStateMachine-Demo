//
//  FakeConfig.swift
//  Swoorn
//
//  Created by Peter IJlst | The Mobile Company on 03/07/2019.
//  Copyright © 2019 Peter IJlst. All rights reserved.
//

import UIKit

enum AppConfig {
    static let values = Values.normal
}

enum Values {
    case normal, fake

    var systemVersion: String {
        switch self {
        case .fake: return "12.0"
        case .normal: return UIDevice.current.systemVersion
        }
    }
}
