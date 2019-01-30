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
	
	func addParticleEffect(center: CGPoint) {
		let emitterTest = CAEmitterLayer()
		emitterTest.emitterPosition = center
		let cell = CAEmitterCell()
		cell.birthRate = 3
		cell.emissionRange = .pi * 2
		cell.color = UIColor.appPink(a: 0.6).cgColor
		cell.alphaRange = 0.5
		cell.lifetime = 5
		cell.velocity = 80
		cell.scale = 0.6
		cell.scaleRange = 0.5
		cell.redRange = 10
		cell.contents = UIImage.init(imageLiteralResourceName: "particle").cgImage
		emitterTest.emitterCells = [cell]
		self.layer.addSublayer(emitterTest)
	}
	
	func rotateAnimation(key: String, rep: Float, duration: Float) {
		let rotateAnim = CABasicAnimation.init(keyPath: "transform.rotation.z")
		rotateAnim.toValue = .pi * 2.0
		rotateAnim.duration = CFTimeInterval(duration)
		rotateAnim.isCumulative = true
		rotateAnim.repeatCount = rep
		rotateAnim.timingFunction = CAMediaTimingFunction(name: .linear)
		self.layer.add(rotateAnim, forKey: key)
	}
	
	func addRippleEffect(pos: CGPoint, size: CGRect) {
		let path = UIBezierPath.init(ovalIn: size)
		
		let shape = CAShapeLayer()
		shape.bounds = size
		shape.path = path.cgPath
		shape.fillColor = UIColor.appPink(a: 0.3).cgColor
		shape.lineWidth = 1
		shape.position = pos
		shape.opacity = 0
		
		let scaleAnim = CABasicAnimation(keyPath: "transform.scale")
		scaleAnim.fromValue = NSValue.init(caTransform3D: CATransform3DIdentity)
		scaleAnim.toValue = NSValue(caTransform3D: CATransform3DMakeScale(5, 5, 2))
		
		let opacityAnim = CABasicAnimation(keyPath: "opacity")
		opacityAnim.fromValue = 1
		opacityAnim.toValue = 0
		
		
		let animation = CAAnimationGroup()
		animation.animations = [scaleAnim, opacityAnim]
		animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
		animation.duration = 2.5
		animation.repeatCount = .infinity
		animation.isRemovedOnCompletion = true
		
		self.layer.addSublayer(shape)
		
		shape.add(animation, forKey: "rippleEffect")
		
	}
}
