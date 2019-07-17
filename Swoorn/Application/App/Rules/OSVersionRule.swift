//
//  OSVersionRule.swift
//  Swoorn
//
//  Created by Peter IJlst | The Mobile Company on 01/07/2019.
//  Copyright © 2019 Peter IJlst. All rights reserved.
//

import SwinjectStateMachine
import Firebase

typealias SystemVersionString = String

// MARK: - OSVersionRule

class OSVersionRule {

    var presenting: PresentingProtocol? = UIApplication.shared.keyWindow?.rootViewController

    private let alertFactory: AlertFactoryProtocol
    private let version: SystemVersionString

    init(alertFactory: AlertFactoryProtocol, systemVersion: SystemVersionString) {
        self.alertFactory = alertFactory
        self.version = systemVersion
    }
}

// MARK: - Rule Conformance

extension OSVersionRule: Rule {

    var isAllowedToFail: Bool {
        return false
    }

    var onFailure: (() -> Void)? {
        return {
            let systemVersion = self.version
            let alert = self.alertFactory.createWithoutActions(
                title: "Could not launch ⚠️",
                message: "This application does not run on iOS \(systemVersion).\nPlease update your phone."
            )
            self.presenting?.present(alert, animated: true)
        }
    }

    var passes: Bool {
        let semaphore = DispatchSemaphore(value: 1)
        let remoteConfig = RemoteConfig.remoteConfig()

        remoteConfig.fetch(withExpirationDuration: 0) { status, _ in
            if status == .success { remoteConfig.activateFetched() }
            semaphore.signal()
        }
        semaphore.wait()

        let data = remoteConfig.configValue(forKey: "blocked_os_versions").dataValue
        guard let blockedVersions = try? JSONDecoder().decode([String].self, from: data) else {
            return true
        }

        let systemVersion = self.version
        if !blockedVersions.contains(systemVersion) {
            return true
        } else {
            return false
        }
    }
}
