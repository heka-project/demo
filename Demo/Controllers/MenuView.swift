//
//  Menu.swift
//  Demo
//
//  Created by Sean Lim on 13/11/18.
//  Copyright © 2018 Heka. All rights reserved.
//

import Foundation
import UIKit

class MenuView: BaseView {
	
	@IBOutlet var connectionIndicator: ConnectionStatus!
	@IBOutlet var tableView: UITableView!
	@IBOutlet var logo: UIImageView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		P2PManager.addListener(self)
		connectionIndicator.isOnline = true
		
		logo.rotateAnimation(key: "load", rep: .infinity, duration: 3.0)
		self.view.addRippleEffect(pos: logo.center, size: self.logo.frame)
	}
}

extension MenuView: P2PServiceListener {
	func networkChanged() {
		self.tableView.reloadData()
		print("🍉 - Network Changed!")
	}
	
	func joinedNetwork() {
		print("🍉 - Connected to network!")
		connectionIndicator.isOnline = true
	}
	
	func disconnectedNetwork() {
		print("🍉 - Lost connection to network!")
		connectionIndicator.isOnline = false
	}

}

extension MenuView: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return P2PManager.service.fragmentCache?.nodes.count ?? 0
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! MenuTableCell
		
		cell.setData(index: indexPath.row, nodes: P2PManager.service.fragmentCache!.nodes)
		return cell
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 50
	}
	
	
}
