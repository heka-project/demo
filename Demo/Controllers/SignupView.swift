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
	
	@IBOutlet var header: UILabel!
	@IBOutlet var textfield: UITextField!
	@IBOutlet var actionButton: UIButton!
	@IBOutlet var username: UILabel!
	@IBOutlet var nricScannerButton: UIButton!
	
	@IBOutlet var bottomPanel: [UIView]!
	@IBOutlet var topPanel: [UIView]!
	
	var name: String?

	override func viewDidLoad() {
		super.viewDidLoad()
		textfield?.attributedPlaceholder =
			NSAttributedString(string: "Enter \(self.restorationIdentifier!)", attributes: [NSAttributedString.Key.foregroundColor: UIColor.appPurple(a: 0.4)])
		self.actionButton?.roundify(5.0)
		self.username?.text = UserDefaults.standard.string(forKey: "user-name")
		
		if self.restorationIdentifier! == "nric" {
			self.setActionButton(title: "Enter NRIC to register", enabled: false)
		}
	}
	
	@IBAction func actionButtonPressed(_ sender: Any) {
		if self.restorationIdentifier == "name" {
			UserDefaults.standard.set(self.name, forKey: "user-name")
			self.performSegue(withIdentifier: "next", sender: self)
		} else if self.restorationIdentifier == "nric" {
			UserDefaults.standard.set(textfield.text!, forKey: "user-nric")
			
			APIManager.shared.registerUser()
		}
	}
	
	func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
		let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
		if self.restorationIdentifier == "name" {
			self.name = newString
			self.actionButton.setTitle(self.name! == " " ? "Next": "👋 Call me \"\(self.name!)\"", for: .normal)
		} else if self.restorationIdentifier == "nric" {
			let regex = try! NSRegularExpression(pattern: "(?i)^[STFG]\\d{7}[A-Z]$")
			if regex.firstMatch(in: newString, options: [], range: NSRange(location: 0, length: newString.utf16.count)) == nil {
				self.setActionButton(title: "Invalid NRIC", enabled: false)
			} else {
				self.setActionButton(title: "Register", enabled: true)
			}
		}
		
		return true
	}
	
	func setActionButton(title: String, enabled: Bool) {
		self.actionButton.titleLabel?.text = title
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
			controller.dismiss(animated: true, completion: nil)
	}
	
	func scannerDidDismiss(_ controller: BarcodeScannerViewController) {
		controller.dismiss(animated: true) {
			
		}
	}
	
	
}
