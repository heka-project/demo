//
//  BarcodeScanner.swift
//  Demo
//
//  Created by Sean Lim on 11/11/18.
//  Copyright © 2018 Heka. All rights reserved.
//

import Foundation
import BarcodeScanner

func buildBarcodeScanner(delegate: UIViewController) -> BarcodeScannerViewController {
	let barcodeScannerViewController = BarcodeScannerViewController()
	barcodeScannerViewController.codeDelegate = (delegate as! BarcodeScannerCodeDelegate)
	barcodeScannerViewController.errorDelegate = delegate as! BarcodeScannerErrorDelegate
	barcodeScannerViewController.dismissalDelegate = delegate as! BarcodeScannerDismissalDelegate
	
	barcodeScannerViewController.headerViewController.closeButton.tintColor = UIColor.appPink(a: 1)
	barcodeScannerViewController.headerViewController.titleLabel.text = "Scan NRIC"
	barcodeScannerViewController.messageViewController.regularTintColor = UIColor.appPink(a: 1)
	
	return barcodeScannerViewController
}
