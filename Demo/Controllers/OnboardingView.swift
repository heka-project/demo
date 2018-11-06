//
//  OnboardView.swift
//  Demo
//
//  Created by Sean Lim on 6/11/18.
//  Copyright © 2018 Heka. All rights reserved.
//

import Foundation
import UIKit
import Hero

class OnboardingView: BaseView, UIGestureRecognizerDelegate {
	
	@IBOutlet var titleLabel: UILabel!
	@IBOutlet var subtitleLabel: UILabel!
	
	var animationType: HeroDefaultAnimationType {
		switch self.restorationIdentifier {
		case "onboard7": return .slide(direction: .left)
		default: return .slide(direction: .up)
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.navigationController?.hero.navigationAnimationType = animationType
		self.setupGestures()
	}
	
	@objc func swipedLeft() {
		if self.restorationIdentifier != "onboard7" {
			self.performSegue(withIdentifier: "next", sender: self)
		}
	}
	
	@objc func swipedRight() {
		self.navigationController?.popViewController(animated: true)
	}
	
	func setupGestures() {
		let leftGesture = UISwipeGestureRecognizer.init(target: self, action: #selector(OnboardingView.swipedLeft))
		leftGesture.direction = .left
		leftGesture.delegate = self
		self.view.addGestureRecognizer(leftGesture)
		
		let rightGesture = UISwipeGestureRecognizer.init(target: self, action: #selector(OnboardingView.swipedRight))
		rightGesture.direction = .right
		rightGesture.delegate = self
		self.view.addGestureRecognizer(rightGesture)
	}
	
}
