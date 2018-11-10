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
	
	var name: String?
	var nric: String?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		textfield.attributedPlaceholder =
			NSAttributedString(string: "Enter name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.appPurple(a: 0.4)])
		self.actionButton.roundify(5.0)
	}
	
	@IBAction func buttonPressed(_ sender: Any) {
		
	}
	
	func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
		self.name = textField.text! + string
		self.actionButton.setTitle(self.name! == " " ? "Next": "👋 Call me \"\(self.name!)\"", for: .normal)
		return true
	}

	func openBarcodeScanner() {
		let barcodeScannerViewController = BarcodeScannerViewController()
		barcodeScannerViewController.codeDelegate = self
		barcodeScannerViewController.errorDelegate = self
		barcodeScannerViewController.dismissalDelegate = self
		
		barcodeScannerViewController.headerViewController.closeButton.tintColor = UIColor.appPink(a: 1)
		barcodeScannerViewController.headerViewController.titleLabel.text = "Scan NRIC"
		barcodeScannerViewController.messageViewController.regularTintColor = UIColor.appPink(a: 1)
		
		present(barcodeScannerViewController, animated: true) {
			
		}
	}
}

extension SignupView: BarcodeScannerErrorDelegate, BarcodeScannerCodeDelegate, BarcodeScannerDismissalDelegate {
	func scanner(_ controller: BarcodeScannerViewController, didReceiveError error: Error) {
		
	}
	
	func scanner(_ controller: BarcodeScannerViewController, didCaptureCode code: String, type: String) {
		let regex = try! NSRegularExpression(pattern: "(?i)^[STFG]\\d{7}[A-Z]$")
		if regex.firstMatch(in: code, options: [], range: NSRange(location: 0, length: code.utf16.count)) != nil {
			UserDefaults.standard.set(code, forKey: "user-nric")
			controller.dismiss(animated: true, completion: nil)
		} else {
			controller.resetWithError()
		}
	}
	
	func scannerDidDismiss(_ controller: BarcodeScannerViewController) {
		controller.dismiss(animated: true) {
			
		}
	}
	
	
}
