//
//  Secrets.swift
//  Demo
//
//  Created by Sean Lim on 29/10/18.
//  Copyright © 2018 Heka. All rights reserved.
//

import Foundation

let secrets = NSDictionary(contentsOfFile: Bundle.main.path(forResource: "Secrets", ofType: "plist") ?? "" )!

