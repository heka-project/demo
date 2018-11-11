//
//  Secrets.swift
//  Demo
//
//  Created by Sean Lim on 29/10/18.
//  Copyright © 2018 Heka. All rights reserved.
//

import Foundation

let secrets = NSDictionary(contentsOfFile: Bundle.main.path(forResource: "Secrets", ofType: "plist") ?? "" )!

let userName = UserDefaults.standard.string(forKey: "user-name")
let userNric = UserDefaults.standard.string(forKey: "user-nric")
let userNrics = UserDefaults.standard.string(forKey: "user-nrics") ?? "1, 2, 3"

var P2PClientID: String?

