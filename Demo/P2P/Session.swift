//
//  Session.swift
//  Demo
//
//  Created by Sean Lim on 25/10/18.
//  Copyright © 2018 Heka. All rights reserved.
//

import Foundation
import MultipeerConnectivity
import SwiftyJSON
import ObjectMapper

extension P2PService: MCSessionDelegate {
	
	func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
		switch state {
		case .connecting:
			print("🔗 - Connecting to peer \(peerID)")
		case .connected:
			print("✅ - Connected to peer \(peerID)")
			self.sayHello()
		default:
			break
		}
	}
	
	func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
		let str = String(data: data, encoding: .utf8)!
		guard let networkJSON = try? JSON(data: data) else {
			print("⚠️ - Failed to parse JSON. Raw: \(str)")
			return
		}
		print("Received JSON \(networkJSON)")
		let fragment = Mapper<ChainFragment>().map(JSON: networkJSON.dictionaryObject!)
		print(fragment!.type)
	}
	
	func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
		print("will start receiving resource")
	}
	
	func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
		print("did finish receiving resource")
	}
	
	func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
		
	}
	
}
