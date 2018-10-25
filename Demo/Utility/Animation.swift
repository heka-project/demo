//
//  Animation.swift
//  Demo
//
//  Created by Sean Lim on 25/10/18.
//  Copyright © 2018 Heka. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
	func rotateAnimation(key: String, rep: Float, duration: Float) {
		let anim = CABasicAnimation.init(keyPath: "transform.rotation.z")
		anim.toValue = NSNumber(value: M_PI * 2.0)
		anim.duration = CFTimeInterval(duration)
		anim.isCumulative = true
		anim.repeatCount = rep
		self.layer.add(anim, forKey: key)
	}
}
