//
//  SignupView.swift
//  Demo
//
//  Created by Sean Lim on 10/11/18.
//  Copyright © 2018 Heka. All rights reserved.
//

import Foundation
import UIKit
import BarcodeScanner

class SignupView: BaseView, UITextFieldDelegate {
	
	let nricRegex = try! NSRegularExpression(pattern: "(?i)^[STFG]\\d{7}[A-Z]$")

	@IBOutlet var header: UILabel!
	@IBOutlet var textfield: UITextField!
	@IBOutlet var actionButton: UIButton!
	@IBOutlet var username: UILabel!
	@IBOutlet var nricScannerButton: UIButton!
	
	@IBOutlet var bottomPanel: [UIView]!
	@IBOutlet var topPanel: [UIView]!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		textfield?.attributedPlaceholder =
			NSAttributedString(string: "Enter \(self.restorationIdentifier!)", attributes: [NSAttributedString.Key.foregroundColor: UIColor.appPurple(a: 0.4)])
		self.actionButton?.roundify(5.0)
		self.username?.text = userName
		if self.restorationIdentifier! == "nric" {
			self.setActionButton(title: "Enter NRIC to register", enabled: false)
		}
	}
	
	@IBAction func actionButtonPressed(_ sender: Any) {
		if self.restorationIdentifier == "name" {
			userName = self.textfield.text!
			self.performSegue(withIdentifier: "next", sender: self)
		} else if self.restorationIdentifier == "nric" {
			self.setActionButton(title: "Verifying...", enabled: false)
			self.verifyNRIC(nric: textfield.text!)
		}
	}
	
	func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
		let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
		if self.restorationIdentifier == "name" {
			self.actionButton.setTitle(newString == " " ? "Next": "👋 I'm \"\(newString)\"", for: .normal)
		} else if self.restorationIdentifier == "nric" {
			self.validateNRIC(nric: newString)
		}
		
		return true
	}
	
	func validateNRIC(nric: String) {
		if nricRegex.firstMatch(in: nric, options: [], range: NSRange(location: 0, length: nric.utf16.count)) == nil {
			self.setActionButton(title: "Invalid NRIC", enabled: false)
		} else {
			self.setActionButton(title: "Register", enabled: true)
		}
	}
	
	func verifyNRIC(nric: String) {
		APIManager.shared.verifyNRIC(nric: nric) { isValid in
			if !isValid {
				self.setActionButton(title: "NRIC already registered", enabled: true)
			} else {
				userNric = nric
				self.registerUser()
			}
		}
	}
	
	func registerUser () {
		APIManager.shared.updateUser { succ in
			if !succ {
				AlertManager(target: self).withFields(title: "Error", message: "Unable to update/register user").addAction(actionTitle: "Dismiss", withCallback: nil).throwsAlert()
				self.setActionButton(title: "Try again", enabled: true)
			} else {
				// Segue to menu
				let controller = Storyboard.main.scene().instantiateViewController(withIdentifier: "root")
				self.navigationController?.pushViewController(controller, animated: true)
			}
		}
	}
	
	func setActionButton(title: String, enabled: Bool) {
		self.actionButton.setTitle(title, for: enabled ? .normal:.disabled)
		self.actionButton.isEnabled = enabled
		self.actionButton.alpha = enabled ? 1.0: 0.5
	}
	
	func textFieldDidEndEditing(_ textField: UITextField) {
		self.bottomPanel?.forEach { $0.alpha = 1.0 }
	}
	
	func textFieldDidBeginEditing(_ textField: UITextField) {
		self.bottomPanel?.forEach { $0.alpha = 0.5 }
	}
	
	@IBAction func nricScannerButtonPress(_ sender: Any) {
		self.openBarcodeScanner()
	}
	
	func openBarcodeScanner() {
		let barcodeScannerViewController = buildBarcodeScanner(delegate: self)
		present(barcodeScannerViewController, animated: true) {
		}
	}
}

extension SignupView: BarcodeScannerErrorDelegate, BarcodeScannerCodeDelegate, BarcodeScannerDismissalDelegate {
	func scanner(_ controller: BarcodeScannerViewController, didReceiveError error: Error) {
		
	}
	
	func scanner(_ controller: BarcodeScannerViewController, didCaptureCode code: String, type: String) {
		self.textfield.text = code
		self.validateNRIC(nric: code)
		controller.dismiss(animated: true, completion: nil)
	}
	
	func scannerDidDismiss(_ controller: BarcodeScannerViewController) {
		controller.dismiss(animated: true) {
			
		}
	}
	
	
}
