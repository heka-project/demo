//
//  Color.swift
//  Demo
//
//  Created by Sean Lim on 25/10/18.
//  Copyright © 2018 Heka. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
	static func appPink(a: CGFloat) -> UIColor {
		return UIColor(red:1.00, green:0.44, blue:0.66, alpha: a)
	}
	
	static func appPurple(a: CGFloat) -> UIColor {
		return UIColor(red:0.48, green:0.48, blue:0.73, alpha: a)
	}
	
	static func appBlack(a: CGFloat) -> UIColor {
		return UIColor(red:0.00, green:0.14, blue:0.22, alpha: a)
	}
}
