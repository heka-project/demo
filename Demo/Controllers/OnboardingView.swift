//
//  OnboardView.swift
//  Demo
//
//  Created by Sean Lim on 6/11/18.
//  Copyright © 2018 Heka. All rights reserved.
//

import Foundation
import UIKit
import Hero

class OnboardingView: BaseView {
	
	@IBOutlet var titleLabel: UILabel!
	@IBOutlet var subtitleLabel: UILabel!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.navigationController?.hero.navigationAnimationType = .slide(direction: .up)
	}
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		self.performSegue(withIdentifier: "next", sender: self)
	}
	
}
