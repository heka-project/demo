//
//  MenuTableCell.swift
//  Demo
//
//  Created by Sean Lim on 13/11/18.
//  Copyright © 2018 Heka. All rights reserved.
//

import Foundation
import UIKit

class MenuTableCell: UITableViewCell {

	@IBOutlet var graphImageView: UIImageView!
	@IBOutlet var graphLabel: UILabel!

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	func setData(index: Int, node: [String: String] ) {
		self.layer.removeAllAnimations()
		self.graphLabel.text = node["name"]
		let isCurrent = Bool(node["isCurrent"]!)

		if isCurrent ?? false {
			self.addRippleEffect(pos: self.graphImageView.center, size: CGRect(origin: self.graphImageView.center, size: CGSize(width: 25, height: 25)))
		}
		
	}
}
