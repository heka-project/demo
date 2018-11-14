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
	private var i1: UIImage? = UIImage(named: "conn-offline")
	private var i2: UIImage? = UIImage(named: "conn-online")

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		Timer.scheduledTimer(timeInterval: 0.7.second, target: self, selector: #selector(ConnectionStatus.updateStatus), userInfo: nil, repeats: true)
	}
	
	@objc func updateStatus() {
		if P2PManager.isConnected {
    		self.image = self.image == self.i1 ? self.i2: self.i1
		} else {
			self.image = i1
		}
	}

	override init(frame: CGRect) {
		super.init(frame: frame)
	}
}
