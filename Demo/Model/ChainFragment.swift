//
//  NetworkData.swift
//  Demo
//
//  Created by Sean Lim on 6/11/18.
//  Copyright © 2018 Heka. All rights reserved.
//

import Foundation
import ObjectMapper
import SwiftyJSON
import SwiftHash

enum FragmentType: String {
	case SAY_HELLO = "SAY_HELLO"
	case UPDATE = "UPDATE"
}

class ChainFragment: Mappable {
	var md5: String?
	var nodes: [String: Any]?
	var currentNode: String?
	var type: FragmentType?
	
	required init?(map: Map) {
		
	}
	
	init(type: FragmentType, nodes: [String: Any], currentNode: String) {
		self.type = type
		self.nodes = nodes
		self.currentNode = currentNode
		self.updateHash()
	}
	
	// Hash on mutation
	private func updateHash() {
		self.md5 = MD5(JSON(["currentNode": currentNode,
							 "nodes": nodes,
							 "type": type
			]).stringValue)
	}
	
	func mapping(map: Map) {
		currentNode <- map["currentNode"]
		nodes <- map["nodes"]
		type <- map["type"]
		md5 <- map["md5"]
	}
	
}
