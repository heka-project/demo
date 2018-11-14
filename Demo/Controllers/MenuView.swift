//
//  Menu.swift
//  Demo
//
//  Created by Sean Lim on 13/11/18.
//  Copyright © 2018 Heka. All rights reserved.
//

import Foundation
import UIKit
import BarcodeScanner

class MenuView: BaseView {
	
	@IBOutlet var connectionIndicator: ConnectionStatus!
	@IBOutlet var tableView: UITableView!
	@IBOutlet var logo: UIImageView!
	
	@IBOutlet var roundables: [UIView]!
	
	@IBOutlet var nameLabel: UILabel!
	@IBOutlet var nricLabel: UILabel!
	
	@IBOutlet var footerButton: UIButton!
	@IBOutlet var actionButton: UIButton!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		P2PManager.addListener(self)

		nameLabel.text = userName
		nricLabel.text = userNric
		
		roundables.forEach {$0.roundify(5.0)}
	}
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		if isCurrent {
			self.actionButton.setTitle("Pass Package", for: .normal)
		}
		self.animate()
	}
	override func willBecomeActive() {
		self.animate()
	}

	private func animate() {
		logo.layer.removeAllAnimations()
		logo.rotateAnimation(key: "load", rep: .infinity, duration: 3.0)
	}
	
	@IBAction func scanButtonPressed(_ sender: Any) {
		if isCurrent {
			self.performSegue(withIdentifier: "collected", sender: self)
		} else {
			let barcodeScannerView = buildBarcodeScanner(delegate: self)
			present(barcodeScannerView, animated: true) {
				
			}
		}
	}
	
	@IBAction func footerButtonPressed(_ sender: Any) {
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
		
		cell.setData(index: indexPath.row, node: P2PManager.service.fragmentCache!.getConnectedNodes()[indexPath.row])
		return cell
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 50
	}
	
	
}

extension MenuView: BarcodeScannerErrorDelegate, BarcodeScannerCodeDelegate, BarcodeScannerDismissalDelegate {
	func scanner(_ controller: BarcodeScannerViewController, didReceiveError error: Error) {
		
	}
	
	func scanner(_ controller: BarcodeScannerViewController, didCaptureCode code: String, type: String) {
		if code == "batch_1" {
			controller.dismiss(animated: true) {
				isCurrent = true
				DispatchQueue.main.async {
					P2PManager.service.fragmentCache?.updateNodeCollected()
					P2PManager.service.updatePeers()
					self.performSegue(withIdentifier: "collected", sender: self)
				}
			}
		}
	}
	
	func scannerDidDismiss(_ controller: BarcodeScannerViewController) {
		controller.dismiss(animated: true) {
			
		}
	}
}
