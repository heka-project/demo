//
//  Chain.swift
//  Demo
//
//  Created by Sean Lim on 9/11/18.
//  Copyright © 2018 Heka. All rights reserved.
//

import Foundation
import ObjectMapper
import SwiftyJSON
import SwiftHash

class Fragment {
	
	var md5: String?
	var nodes: [String: Any]?
	
	init() {
		
	}
	
	init(deviceID: String, meta: [String: Any]) {
		self.nodes = [deviceID: meta]
		self.updateHash()
	}
	
	private func updateHash() {
		self.md5 = MD5(JSON(["nodes": nodes,
			]).stringValue)
	}
	
	
}
