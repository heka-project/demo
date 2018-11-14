//
//  CollectedView.swift
//  Demo
//
//  Created by Sean Lim on 14/11/18.
//  Copyright © 2018 Heka. All rights reserved.
//

import Foundation
import UIKit
import Hero

class CollectedView: BaseView {
	
	@IBOutlet var barcode: UIImageView!
	@IBOutlet var roundables: [UIView]!
	@IBOutlet var boxView: UIView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.navigationController?.hero.navigationAnimationType = .slide(direction: .left)
		self.boxView.hero.modifiers = [.translate(y: -self.view.frame.height), .delay(0.5)]
		
		roundables.forEach {
			$0.roundify(5.0)
		}
		
		barcode.image = Barcode.fromString(string: "batch_1")
		
		P2PManager.addListener(self)

	}
	
	@IBAction func backButtonPress(_ sender: Any) {
		self.navigationController?.hero.navigationAnimationType = .slide(direction: .right)
		self.navigationController?.popViewController(animated: true)
	}
	
}

extension CollectedView: P2PServiceListener {
	func joinedNetwork() {
		
	}
	
	func disconnectedNetwork() {
		
	}
	
	func networkUpdated() {
		let currentNode = P2PManager.service.fragmentCache?.getDeviceNode()
		if !Bool(currentNode!["isCurrent"]!)! {
			isCurrent = false
			UIView.animate(withDuration: 0.6, delay: 0.5, options: .curveEaseOut, animations: {
				self.boxView.center = CGPoint(x: self.boxView.center.x, y: self.view.frame.height * 2)
			}) { done in
				self.backButtonPress(self)
			}
		}
	}
	
	
}



