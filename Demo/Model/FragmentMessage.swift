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

// Datagram

enum MessageType: String {
	case SAY_HELLO = "SAY_HELLO"
	case UPDATE = "UPDATE"
}

class FragmentMessage: Mappable {
	
	var type: MessageType?
	var fragment: Fragment?
	
	required init?(map: Map) {
		self.fragment = Fragment()
	}
	
	init(type: MessageType, fragment: Fragment) {
		self.type = type
		self.fragment = fragment
	}
	
	func mapping(map: Map) {
		type <- map["type"]
		self.fragment!.nodes <- map["nodes"]
		self.fragment!.md5 <- map["md5"]
	}
	
}
