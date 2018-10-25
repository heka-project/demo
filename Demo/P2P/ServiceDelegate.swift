//
//  ServiceDelegate.swift
//  ConnectedColors
//
//  Created by Sean Lim on 18/10/18.
//  Copyright © 2018 Example. All rights reserved.
//

import Foundation

protocol ServiceDelegate {
	func connectedNodesChanged(manager: Service, connectedNodes: [String])
	// Color example
	func colorChanged(manager: Service, colorString: String)
}
