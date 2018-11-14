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
	@IBOutlet var backgroundCard: UIView!
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	func setData(index: Int, nodes: [[String: String]] ) {
		self.graphLabel.text = nodes[index]["name"]
		backgroundCard.roundify(5.0)
	}
}
