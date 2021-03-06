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

var debug: String = """
_______ _       _______
|\\     /(  ____ | \\    /(  ___  )
| )   ( | (    \\|  \\  / | (   ) |
| (___) | (__   |  (_/ /| (___) |
|  ___  |  __)  |   _ ( |  ___  |
| (   ) | (     |  ( \\ \\| (   ) |
| )   ( | (____/|  /  \\ \\ | ) ( |
|/     \\(_______|_/    \\|/     \\|

(\(P2PClientID!))
\n\n
"""

var userName: String {
	get {return UserDefaults.standard.string(forKey: "user-name") ?? ""}
	set {UserDefaults.standard.set(newValue, forKey: "user-name")}
}
var userNric: String {
	get {return UserDefaults.standard.string(forKey: "user-nric") ?? ""}
	set {UserDefaults.standard.set(newValue, forKey: "user-nric")}
}
let userNrics = UserDefaults.standard.string(forKey: "user-nrics") ?? "1, 2, 3"

var doneOnboarding: Bool {
	get {return UserDefaults.standard.bool(forKey: "done-onboarding")}
	set {UserDefaults.standard.set(newValue, forKey: "done-onboarding")}
}
var signedUp: Bool {
	get {return UserDefaults.standard.bool(forKey: "signed-up")}
	set {UserDefaults.standard.set(newValue, forKey: "signed-up")}
}
var collected: Bool {
	get { return UserDefaults.standard.bool(forKey: "collected")}
	set { UserDefaults.standard.set(newValue, forKey: "collected")}
}

var isCurrent: Bool {
	get { return UserDefaults.standard.bool(forKey: "is-current")}
	set { UserDefaults.standard.set(newValue, forKey: "is-current")}
}
var P2PClientID: String? {
	get {return UserDefaults.standard.string(forKey: "p2p-id")}
	set {UserDefaults.standard.set(newValue, forKey: "p2p-id")}
}

enum Storyboard: String {
	case onboarding = "Onboarding"
	case signup = "SignUp"
	case main = "Main"
	
	func scene() -> UIStoryboard {
		return UIStoryboard.init(name: self.rawValue , bundle: .main)
	}
}
