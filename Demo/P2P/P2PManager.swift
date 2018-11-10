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
	
	static func receivedUpdate(manager: P2PService, fragment: FragmentMessage) {
		self.listeners.forEach { listener in
			listener.receivedUpdate(manager: manager, fragment: fragment)
		}
	}
	
	static func receivedHello(manager: P2PService, fragment: FragmentMessage) {
		self.listeners.forEach { listener in
			listener.receivedHello(manager: manager, fragment: fragment)
		}
	}
	
	static func log(manager: P2PService, content: String) {
		self.listeners.forEach { listener in
			listener.log(manager: manager, content: content)
		}
	}
}
