//
//  Connection.swift
//  Demo
//
//  Created by Sean Lim on 13/11/18.
//  Copyright © 2018 Heka. All rights reserved.
//

import Foundation
import UIKit

class ConnectionStatus: UIImageView {
	var i1: UIImage? = UIImage(named: "conn-offline")
	var i2: UIImage? = UIImage(named: "conn-online")
	var isOnline: Bool = false
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		Timer.scheduledTimer(withTimeInterval: 1.second, repeats: true) { timer in
			if self.isOnline {
				self.image = self.i2
			} else {
    			self.image = self.image == self.i1 ? self.i2: self.i1
			}
		}
	}

	override init(frame: CGRect) {
		super.init(frame: frame)
		
	}
}
