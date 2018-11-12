//
//  Timer.swift
//  Demo
//
//  Created by Sean Lim on 12/11/18.
//  Copyright © 2018 Heka. All rights reserved.
//

import Foundation

private class TimerActor {
	var block: () -> ()
	
	init(block: @escaping () -> ()) {
		self.block = block
	}
	
	@objc dynamic func fire() {
		block()
	}
}

extension Timer {
	convenience init(_ intervalFromNow: TimeInterval, block: @escaping () -> ()) {
		let actor = TimerActor(block: block)
		self.init(timeInterval: intervalFromNow, target: actor, selector: #selector(TimerActor.fire), userInfo: nil, repeats: false)
	}
	
	convenience init(every interval: TimeInterval, block: @escaping () -> ()) {
		let actor = TimerActor(block: block)
		self.init(timeInterval: interval, target: actor, selector: #selector(TimerActor.fire), userInfo: nil, repeats: true)
	}
	
	class func schedule(intervalFromNow: TimeInterval, block: @escaping () -> ()) -> Timer {
		let timer = Timer(intervalFromNow, block: block)
		RunLoop.current.add(timer, forMode: RunLoop.Mode.default)
		return timer
	}
	
	class func schedule(every interval: TimeInterval, block: @escaping () -> ()) -> Timer {
		let timer = Timer(interval, block: block)
		RunLoop.current.add(timer, forMode: RunLoop.Mode.default)
		return timer
	}
}
