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
	@IBOutlet var doneButton: UIButton!
	
	var animationType: HeroDefaultAnimationType {
		switch self.restorationIdentifier {
		case "onboard7": return .slide(direction: .left)
		default: return .slide(direction: .up)
		}
	}
	
	var onboardCompletion: Float {
		return (["onboard1" : 0, "onboard2" : 1, "onboard3" : 2, "onboard4" : 3, "onboard5" : 4, "onboard6" : 5, "onboard7" : 6][self.restorationIdentifier] ?? 0 ) / 6
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.navigationController?.hero.navigationAnimationType = animationType
		
		let progressIndicator = UIProgressView.init(frame: CGRect.init(x: 0, y: self.view.frame.height - 2, width: self.view.frame.width, height: 20))
		progressIndicator.tintColor = UIColor.appPink(a: 1)
		progressIndicator.trackTintColor = .clear
		progressIndicator.setProgress(onboardCompletion, animated: false)
		progressIndicator.hero.id = "progress"
		self.view.addSubview(progressIndicator)
		
		doneButton?.roundify(5.0)
	}
	
	override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
		let point = touches.first?.location(in: self.view)
		if point!.x > self.view.frame.width/2 && self.restorationIdentifier != "onboard7" {
				self.performSegue(withIdentifier: "next", sender: self)
		} else if point!.x < self.view.frame.width/2 {
			self.navigationController?.popViewController(animated: true)
		}
	}
	
	@IBAction func doneButtonPress(_ sender: Any) {
		doneOnboarding = true
		let signupView = UIStoryboard(name: "SignUp", bundle: .main).instantiateViewController(withIdentifier: "signup")
		self.navigationController!.pushViewController(signupView, animated: true)
	}
	
}
