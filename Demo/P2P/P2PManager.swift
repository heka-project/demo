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
	
	required init() {
		P2PManager.service.delegate = self
	}
	
	static func addListener(_ listener: P2PServiceListener) {
		self.listeners.append(listener)
	}
	
	static func purgeListeners() {
		self.listeners.removeAll()
	}
	
	func networkUpdated(manager: P2PService, fragment: FragmentMessage) {
		P2PManager.listeners.forEach { listener in
		}
	}
	
	func receivedHello(manager: P2PService, fragment: FragmentMessage) {
		P2PManager.listeners.forEach { listener in
			listener.joinedNetwork()
		}
	}
	
	func lostConnection(manager: P2PService) {
		P2PManager.listeners.forEach { listener in
			listener.disconnectedNetwork()
		}
	}
	
}
