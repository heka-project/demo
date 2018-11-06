//
//  ViewController.swift
//  Demo
//
//  Created by Sean Lim on 23/10/18.
//  Copyright © 2018 Heka. All rights reserved.
//

import UIKit
import Hero

class BaseView: UIViewController {
	
	override var preferredStatusBarStyle: UIStatusBarStyle {
		return .lightContent
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.navigationController?.hero.navigationAnimationType = .fade
		UILabel.appearance(whenContainedInInstancesOf: [UIAlertController.self]).numberOfLines = 0
		transitionSetup()
	}
	
	func transitionSetup() {}


}

