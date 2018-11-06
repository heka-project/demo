//
//  UIView.swift
//  Demo
//
//  Created by Sean Lim on 6/11/18.
//  Copyright © 2018 Heka. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
	func roundify(_ amount: CGFloat) {
		self.layer.cornerRadius = amount
		self.clipsToBounds = true
	}
}
