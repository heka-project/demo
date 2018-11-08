//
//  Browser.swift
//  Demo
//
//  Created by Sean Lim on 25/10/18.
//  Copyright © 2018 Heka. All rights reserved.
//

import Foundation
import MultipeerConnectivity

extension P2PService: MCNearbyServiceBrowserDelegate {
	func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) {
		NSLog("%@", "foundPeer: \(peerID)")
		print("Inviting peer \(peerID) ...")
		
		// Invite all peers that we find
		browser.invitePeer(peerID, to: self.session, withContext: nil, timeout: 10)
	}
	
	func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
		NSLog("%@", "lostPeer: \(peerID)")
	}
	
	func browser(_ browser: MCNearbyServiceBrowser, didNotStartBrowsingForPeers error: Error) {
		NSLog("%@", "didNotStartBrowsingForPeers: \(error)")
		
	}
}
