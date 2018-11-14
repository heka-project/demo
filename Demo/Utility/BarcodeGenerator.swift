//
//  BarcodeGenerator.swift
//  Demo
//
//  Created by Sean Lim on 14/11/18.
//  Copyright © 2018 Heka. All rights reserved.
//

import Foundation
import UIKit

class Barcode {
	
	class func fromString(string : String) -> UIImage? {
		
		let data = string.data(using: .ascii)
		let filter = CIFilter(name: "CICode128BarcodeGenerator")
		filter?.setValue(data, forKey: "inputMessage")
		
		return UIImage(ciImage: (filter?.outputImage)!)
	}
	
}
