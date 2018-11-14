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
	var nodes: [[String: String]] = []

	init() {
		
	}
	
	init(meta: [String: String]) {
		self.nodes.append(meta)
		self.updateHash()
	}
	
	func addNode(meta: [String: String]) {
		self.nodes.append(meta)
		self.updateHash()
	}
	
	func removeNode(id: String) {
		self.nodes = self.nodes.filter {$0["id"] != id}
		self.updateHash()
	}
	
	func getConnectedNodes() -> [[String: String]] {
		return nodes.filter {$0["id"] != P2PClientID!}
	}
	
	func updateFragment(newFragment: Fragment) {
		var mergeSet: Set<[String: String]> = Set()
		let combined = self.nodes + newFragment.nodes
		combined.forEach { (node) in
			mergeSet.insert(node)
		}
		self.nodes = Array(mergeSet)
		
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
		self.nodes = self.nodes.sorted{
			return ($0["id"] as! String) < ($1["id"] as! String)
		}
		let sortedNodes = self.nodes.map{$0.sorted{$0.key < $1.key}}
		return JSON([
			"nodes": sortedNodes.description,
			]).rawString()!
	}
	
	
}
