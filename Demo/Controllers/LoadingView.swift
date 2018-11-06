//
//  ViewController.swift
//  Demo
//
//  Created by Sean Lim on 25/10/18.
//  Copyright © 2018 Heka. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper
import SwiftyJSON

class LoadingView: BaseView {
	
	@IBOutlet var logo: UIImageView!
	
	let service = P2PService()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		service.delegate = self
		
	}
	
	override func viewDidAppear(_ animated: Bool) {
		self.animateLoadScreen()
	}
	
	func animateLoadScreen() {
		self.view.alpha = 0
		UIView.animate(withDuration: 1.0) {
			self.view.alpha = 1
		}
		self.view.addParticleEffect(center: self.logo.center)
		self.logo.rotateAnimation(key: "load", rep: .infinity, duration: 2.5)
		self.view.addRippleEffect(pos: self.view.center, size: self.logo.frame)
		self.view.bringSubviewToFront(self.logo)
	}
	
	@IBAction func ping(_ sender: Any) {
		let blankNetwork = NetworkData(map: Map.init(mappingType: .fromJSON, JSON: [:]))
		blankNetwork?.nodes = []
		blankNetwork?.currentNodes = [
			"from": "1",
			"to": "2"
		]
		
		service.send(networkData: blankNetwork!)
	}
	
}

extension LoadingView: P2PServiceDelegate {
	func dataChanged(manager: P2PService, data: NetworkData) {
		print("Received data: \(data.nodes?.count) Nodes in the network")
	}
	
	func connectedNodesChanged(manager: P2PService, connectedNodes: [String]) {
		print("connected to node \(connectedNodes)")
	}
	
}
