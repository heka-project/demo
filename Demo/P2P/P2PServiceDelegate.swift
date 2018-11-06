//
//  ServiceDelegate.swift
//  ConnectedColors
//
//  Created by Sean Lim on 18/10/18.
//  Copyright © 2018 Example. All rights reserved.
//

import Foundation

protocol P2PServiceDelegate {
	func connectedNodesChanged(manager: P2PService, connectedNodes: [String])
	func dataChanged(manager: P2PService, data: NetworkData)
}
