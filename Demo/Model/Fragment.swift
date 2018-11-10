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
	var nodes: [[String: Any]] = []
	
	init() {
		
	}
	
	init(meta: [String: Any]) {
		self.nodes.append(meta)
		self.updateHash()
	}
	
	func addNode(meta: [String: Any]) {
		self.nodes.append(meta)
		self.nodes = self.nodes.sorted{
			return ($0["id"] as! String) < ($1["id"] as! String)
		}
		self.updateHash()
	}
	
	func removeNode(id: String) {
		self.nodes = self.nodes.filter {$0["id"] as! String != id}
		self.updateHash()
	}
	
	func updateHash() {
		let stringRepresentation = mapToString()
		// Generate a hash of self
		self.md5 = MD5(stringRepresentation)
	}
	
	// Map contents to a string
	private func mapToString() -> String {
		// Sort nodes
		let sortedNodes = self.nodes.map{$0.sorted{$0.key < $1.key}}
		return JSON([
			"nodes": sortedNodes.description
			]).rawString()!
	}
	
	
}
