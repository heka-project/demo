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
		case .notConnected:
			print("⚠️ - Lost connection to peer \(peerID)")
			fragmentCache!.removeNode(id: peerID.displayName)
			if fragmentCache!.nodes.count <= 1 {
				self.delegate!.lostConnection(manager: self)
			}
			break
		}
	}
	
	func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
		let str = String(data: data, encoding: .utf8)!
		guard let networkJSON = try? JSON(data: data) else {
			print("⚠️ - Failed to parse JSON. Raw: \(str)")
			return
		}
		
//		print("|==> \(networkJSON)")
		
		let fragmentMessage = Mapper<FragmentMessage>().map(JSON: networkJSON.dictionaryObject!)
		
		DispatchQueue.main.async {
			self.handleFragmentMessage(fragmentMessage!)
		}
	}
	
	func handleFragmentMessage(_ fragmentMessage: FragmentMessage) {
		switch fragmentMessage.type! {
		case .SAY_HELLO:
			self.fragmentCache = fragmentMessage.fragment
			self.fragmentCache!.addNode(meta: ["name": userName, "qty": String(userQuantity), "id":
				self.peerID.displayName])
			self.updatePeers()
		case .UPDATE:
			if fragmentMessage.fragment.md5 != self.fragmentCache!.md5 {
				print("⚠️ Will update self and peers...")
				// TODO: temp naive fragment updating, need to add a merge helper
//				self.fragmentCache = fragmentMessage.fragment
//				self.fragmentCache!.updateHash() // Update hash (no helper method yet)
				self.fragmentCache!.updateFragment(newFragment: fragmentMessage.fragment)
				
				// Update other peers on the network
				self.updatePeers()
			} else {
				print("✅ Node already has latest fragment, not updating.")
			}
		}
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
