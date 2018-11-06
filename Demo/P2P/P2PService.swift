//
//  Service.swift
//  ConnectedColors
//
//  Created by Sean Lim on 18/10/18.
//  Copyright © 2018 Example. All rights reserved.
//

import Foundation
import MultipeerConnectivity


class P2PService: NSObject {
	
	var delegate: P2PServiceDelegate?
	
	lazy var session: MCSession = {
		let session = MCSession(peer: self.peerID, securityIdentity: nil, encryptionPreference: .required)
		session.delegate = self
		return session
	}()
	
	private let serviceType = secrets.value(forKey: "root") as! String
	private let peerID = MCPeerID(displayName: UIDevice.current.name)
	
	private let serviceAdvertiser: MCNearbyServiceAdvertiser
	private let serviceBrowser: MCNearbyServiceBrowser
	
	override init() {
		self.serviceAdvertiser = MCNearbyServiceAdvertiser(peer: peerID, discoveryInfo: nil, serviceType: serviceType)
		self.serviceBrowser = MCNearbyServiceBrowser.init(peer: peerID, serviceType: serviceType)
		
		super.init()

		self.serviceAdvertiser.delegate = self
		self.serviceAdvertiser.startAdvertisingPeer()
		
		self.serviceBrowser.delegate = self
		self.serviceBrowser.startBrowsingForPeers()
				
	}
	
	deinit {
		self.serviceAdvertiser.stopAdvertisingPeer()
		self.serviceBrowser.stopBrowsingForPeers()
	}
	
	// send empty network
	func send(networkData: NetworkData) {
		print("sending... \(networkData.toJSON())")
		if session.connectedPeers.count > 0 {
			do {
				try self.session.send(try! networkData.toJSON().rawData(), toPeers: session.connectedPeers, with: .reliable)
			} catch {
				print(error.localizedDescription)
			}
		}
	}
}
