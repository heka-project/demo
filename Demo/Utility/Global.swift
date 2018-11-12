//
//  Secrets.swift
//  Demo
//
//  Created by Sean Lim on 29/10/18.
//  Copyright © 2018 Heka. All rights reserved.
//

import Foundation
import UIKit

let secrets = NSDictionary(contentsOfFile: Bundle.main.path(forResource: "Secrets", ofType: "plist") ?? "" )!

var userName: String {
	get {
		return UserDefaults.standard.string(forKey: "user-name") ?? ""
	}
	set {
		UserDefaults.standard.set(newValue, forKey: "user-name")
	}
}
var userNric: String {
	get {
		return UserDefaults.standard.string(forKey: "user-nric") ?? ""
	}
	set {
		UserDefaults.standard.set(newValue, forKey: "user-nric")
	}
}
let userNrics = UserDefaults.standard.string(forKey: "user-nrics") ?? "1, 2, 3"

var P2PClientID: String?

enum Storyboard: String {
	case onboarding = "Onboarding"
	case signup = "SignUp"
	case main = "Main"
	
	func scene() -> UIStoryboard {
		return UIStoryboard.init(name: self.rawValue , bundle: .main)
	}
}
