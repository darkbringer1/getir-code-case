//
//  NetworkChecker.swift
//  ShoppingApp
//
//  Created by Dogukaan Kılıçarslan on 2.10.2022.
//

import Foundation
import Network

typealias NetworkListener = (NetworkStates) -> Void

class NetworkCheckerManager {

    public static let shared = NetworkCheckerManager()

    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "InternetConnectionMonitor")

    private var networkListener: NetworkListener?

    init() {}

    func startNetworkListener(_ completion: @escaping NetworkListener) {
        monitor.pathUpdateHandler = { pathUpdateHandler in
            if pathUpdateHandler.status == .satisfied {
                self.networkListener?(.online)
            } else {
                self.networkListener?(.offline)
            }
        }
        monitor.start(queue: queue)
        networkListener = completion
    }
}

enum NetworkStates {
    case online
    case offline
}
