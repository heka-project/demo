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
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	func setData(index: Int, nodes: [[String: String]] ) {
		switch index {
		case 0:
			graphImageView.image = UIImage(named: "connector-head")
		case nodes.count - 1:
			graphImageView.image = UIImage(named: "connector-tail")
		default:
			graphImageView.image = UIImage(named:"connector-body")
		}
	}
}
