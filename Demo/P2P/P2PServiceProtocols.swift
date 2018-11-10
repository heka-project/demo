//
//  ServiceDelegate.swift
//  ConnectedColors
//
//  Created by Sean Lim on 18/10/18.
//  Copyright © 2018 Example. All rights reserved.
//

import Foundation

protocol P2PServiceDelegate {
	func receivedUpdate(manager: P2PService, fragment: FragmentMessage)
	func receivedHello(manager: P2PService, fragment: FragmentMessage)
	func log(manager: P2PService, content: String)
}
