//
//  ViewController.swift
//  Demo
//
//  Created by Sean Lim on 25/10/18.
//  Copyright © 2018 Heka. All rights reserved.
//

import Foundation
import UIKit

class LoadingView: BaseViewController {
	
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
	
}

extension LoadingView: P2PServiceDelegate {
	func connectedNodesChanged(manager: P2PService, connectedNodes: [String]) {
		print("connected to node \(connectedNodes)")
	}
	
	func colorChanged(manager: P2PService, colorString: String) {
		
	}
	
	
}
