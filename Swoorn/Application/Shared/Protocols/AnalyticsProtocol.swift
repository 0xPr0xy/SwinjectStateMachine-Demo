//
//  AnalyticsProtocol.swift
//  Swoorn
//

import Firebase

//sourcery: AutoMockable
protocol EventProtocol {
    var name: String { get }
    var parameters: [String: Any]? { get }
}

//sourcery: AutoMockable
protocol AnalyticsProtocol {
    func log(_ event: EventProtocol)
}

extension AnalyticsProtocol {
    func log(_ event: EventProtocol) {
        Analytics.logEvent(event.name, parameters: event.parameters)
    }
}

class AnalyticsEngine: AnalyticsProtocol {}
