//
//  ViewController.swift
//  Demo
//
//  Created by Sean Lim on 25/10/18.
//  Copyright © 2018 Heka. All rights reserved.
//

import Foundation
import UIKit

class ViewController: BaseViewController {
	
	@IBOutlet var logo: UIImageView!
	
	let emitterTest = CAEmitterLayer()
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	override func viewDidAppear(_ animated: Bool) {
		emitterTest.emitterPosition = self.logo.center
		let cell = CAEmitterCell()
		cell.birthRate = 3
		cell.emissionRange = .pi * 2
		cell.color = UIColor.appPink(a: 1.0).cgColor
		cell.alphaRange = 1.0
		cell.lifetime = 5
		cell.velocity = 80
		cell.scale = 0.6
		cell.scaleRange = 0.5
		cell.redRange = 10
		cell.contents = UIImage.init(imageLiteralResourceName: "particle").cgImage
		emitterTest.emitterCells = [cell]
		self.view.layer.addSublayer(emitterTest)
		self.logo.rotateAnimation(key: "load", rep: .infinity, duration: 2.5)
		self.view.addRippleEffect(pos: self.view.center, size: self.logo.frame)
		self.view.bringSubviewToFront(self.logo)
	}
	
}
