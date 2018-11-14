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
	
	@IBOutlet var roundables: [UIView]!
	
	@IBOutlet var nameLabel: UILabel!
	@IBOutlet var nricLabel: UILabel!
	
	@IBOutlet var footerButton: UIButton!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		P2PManager.addListener(self)

		nameLabel.text = userName
		nricLabel.text = userNric
		
		roundables.forEach {$0.roundify(5.0)}
		self.animate()
	}
	
	override func willBecomeActive() {
		self.animate()
	}
	
	private func animate() {
		logo.rotateAnimation(key: "load", rep: .infinity, duration: 3.0)
	}
}

extension MenuView: P2PServiceListener {
	func networkUpdated() {
		DispatchQueue.main.async {
    		self.tableView.reloadData()
		}
		print("🍉 - Network Changed!")
	}

	func joinedNetwork() {
		print("🍉 - Connected to network!")
	}
	
	func disconnectedNetwork() {
		print("🍉 - Lost connection to network!")
	}
}

extension MenuView: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return P2PManager.service.fragmentCache?.getConnectedNodes().count ?? 0
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! MenuTableCell
		
		cell.setData(index: indexPath.row, nodes: P2PManager.service.fragmentCache!.getConnectedNodes())
		return cell
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 50
	}
	
	
}
