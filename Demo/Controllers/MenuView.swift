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
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		P2PManager.addListener(self)
		connectionIndicator.isOnline = true
	}
}

extension MenuView: P2PServiceListener {
	func joinedNetwork() {
		tableView.reloadData()
	}
	
	func disconnectedNetwork() {
		
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
