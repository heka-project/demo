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
			print("P2P: 🔗 - Connecting to peer \(peerID.displayName)")
		case .connected:
			print("P2P: ✅ - Connected to peer \(peerID.displayName)")
			self.sayHello()
		case .notConnected:
			print("P2P: ⚠️ - Lost connection to peer \(peerID.displayName)")
			fragmentCache!.removeNode(id: peerID.displayName)
			if fragmentCache!.nodes.count <= 1 {
				self.delegate!.lostConnection(manager: self)
			} else {
				self.updatePeers()
			}
			break
		}
	}
	
	func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
		guard let networkJSON = try? JSON(data: data) else {
			print("P2P: ⚠️ - Failed to parse JSON. Raw: \(String(data: data, encoding: .utf8)!)")
			return
		}
		
		print("Network: |==> \(networkJSON)")
		
		let fragmentMessage = Mapper<FragmentMessage>().map(JSON: networkJSON.dictionaryObject!)
		
		DispatchQueue.main.async {
			self.handleFragmentMessage(fragmentMessage!)
		}
	}
	
	func handleFragmentMessage(_ fragmentMessage: FragmentMessage) {
		switch fragmentMessage.type! {
		case .SAY_HELLO:
			self.fragmentCache = fragmentMessage.fragment
			self.fragmentCache!.addNode(meta: ["name": userName, "qty": userNrics, "id":
				self.peerID.displayName])
			self.updatePeers()
		case .UPDATE:
			if fragmentMessage.fragment.md5 != self.fragmentCache!.md5 {
				print("P2P: ⚠️ Will update self and peers...")
				self.fragmentCache!.updateFragment(newFragment: fragmentMessage.fragment)
				
				// Update other peers on the network
				self.updatePeers()
			} else {
				print("P2P: ✅ Node already has latest fragment, not updating.")
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
