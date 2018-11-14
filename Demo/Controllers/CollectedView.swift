//
//  CollectedView.swift
//  Demo
//
//  Created by Sean Lim on 14/11/18.
//  Copyright © 2018 Heka. All rights reserved.
//

import Foundation
import UIKit

class CollectedView: BaseView {
	
	@IBOutlet var barcode: UIImageView!
	@IBOutlet var roundables: [UIView]!

	override func viewDidLoad() {
		super.viewDidLoad()
		
		roundables.forEach {
			$0.roundify(5.0)
		}
		
		barcode.image = Barcode.fromString(string: "batch_1")
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		DispatchQueue.main.async {
			P2PManager.service.fragmentCache?.updateNodeCollected()
			P2PManager.service.updatePeers()
		}
		
	}
}



