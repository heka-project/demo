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

class NetworkData: Mappable {
	var nodes: [Node]?
	var currentNodes: [String: String]?
	
	required init?(map: Map) {
		
	}
	
	func toJSON() -> JSON {
		return JSON([
			"currentNodes": currentNodes,
			"nodes": nodes
			])
	}
	
	func mapping(map: Map) {
		currentNodes <- map["currentNodes"]
	}
	
	func getNode(_with id: String) -> Node? {
		return nodes?.filter{$0.id == id}.first
	}
}
