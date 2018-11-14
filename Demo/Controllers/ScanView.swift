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

class ScanView: BaseView {
	
	@IBOutlet var logo: UIImageView!
	@IBOutlet var messageLabel: UILabel!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.setupP2PClient()
		self.animateLoadScreen()
	}
	
	internal func setupP2PClient() {
		P2PManager()
		P2PManager.addListener(self)
	}
	
	override func willBecomeActive() {
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
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		self.performSegue(withIdentifier: "menu", sender: self)
	}

}

extension ScanView: P2PServiceListener {
	func networkUpdated() {
		print("🍉 - Network Changed!")
	}

	func joinedNetwork() {
		print("🍉 - Connected to network!")
		self.messageLabel.text = "Connected!"
		self.performSegue(withIdentifier: "menu", sender: self)
	}
	
	func disconnectedNetwork() {
		print("🍉 - Lost connection to network!")
	}
	
}
