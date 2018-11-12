//
//  Time.swift
//  Demo
//
//  Created by Sean Lim on 12/11/18.
//  Copyright © 2018 Heka. All rights reserved.
//

import Foundation

extension Int {
	var second:  TimeInterval { return TimeInterval(self) }
	var seconds: TimeInterval { return TimeInterval(self) }
	var minute:  TimeInterval { return TimeInterval(self * 60) }
	var minutes: TimeInterval { return TimeInterval(self * 60) }
	var hour:    TimeInterval { return TimeInterval(self * 3600) }
	var hours:   TimeInterval { return TimeInterval(self * 3600) }
}

extension Double {
	var second:  TimeInterval { return self }
	var seconds: TimeInterval { return self }
	var minute:  TimeInterval { return self * 60 }
	var minutes: TimeInterval { return self * 60 }
	var hour:    TimeInterval { return self * 3600 }
	var hours:   TimeInterval { return self * 3600 }
}
