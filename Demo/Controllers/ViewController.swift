//
//  ViewController.swift
//  Demo
//
//  Created by Sean Lim on 25/10/18.
//  Copyright © 2018 Heka. All rights reserved.
//

import Foundation
import UIKit

class ViewController: BaseViewController {
	
	@IBOutlet var logo: UIImageView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		print("hi mom!")
	}
	
	override func viewDidAppear(_ animated: Bool) {
		self.logo.rotateAnimation(key: "load", rep: .infinity, duration: 2.5)
	}
	
	
}
