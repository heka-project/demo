//
//  P2PManager.swift
//  Demo
//
//  Created by Sean Lim on 10/11/18.
//  Copyright © 2018 Heka. All rights reserved.
//

import Foundation
import UIKit

class P2PManager: P2PServiceDelegate {

	static private var listeners: [P2PServiceListener] = []
	static let service = P2PService()
	
	static var isConnected: Bool = false
	
	required init() {
		P2PManager.service.delegate = self
	}
	
	static func addListener(_ listener: P2PServiceListener) {
		self.listeners.append(listener)
	}
	
	static func purgeListeners() {
		self.listeners.removeAll()
	}
	
	func networkUpdated(manager: P2PService, fragment: Fragment) {
		APIManager.shared.updateChainState()
		P2PManager.listeners.forEach { listener in
			listener.networkUpdated()
		}
	}
	
	func receivedHello(manager: P2PService, fragment: Fragment) {
		P2PManager.isConnected = true
		P2PManager.listeners.forEach { listener in
			listener.joinedNetwork()
		}
	}
	
	func lostConnection(manager: P2PService) {
		P2PManager.isConnected = false
		P2PManager.listeners.forEach { listener in
			listener.disconnectedNetwork()
		}
	}
	
}
