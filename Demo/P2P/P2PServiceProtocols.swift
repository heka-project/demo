//
//  ServiceDelegate.swift
//  ConnectedColors
//
//  Created by Sean Lim on 18/10/18.
//  Copyright © 2018 Example. All rights reserved.
//

import Foundation
import UIKit

protocol P2PServiceDelegate {
	func networkUpdated(manager: P2PService, fragment: Fragment)
	func receivedHello(manager: P2PService, fragment: Fragment)
	func lostConnection(manager: P2PService)
}

protocol P2PServiceListener {
	func joinedNetwork()
	func disconnectedNetwork()
	func networkUpdated()
}
