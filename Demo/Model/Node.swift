//
//  Node.swift
//  Demo
//
//  Created by Sean Lim on 6/11/18.
//  Copyright © 2018 Heka. All rights reserved.
//

import Foundation
import ObjectMapper

class Node: Mappable {
	var name: String?
	var id: String?
	var qty: Int?
	
	required init?(map: Map) {
		
	}
	
	func mapping(map: Map) {
		name <- map["name"]
		id <- map["id"]
		qty <- map["qty"]
	}
}
