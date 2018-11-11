//
//  APIManager.swift
//  Demo
//
//  Created by Sean Lim on 11/11/18.
//  Copyright © 2018 Heka. All rights reserved.
//

import Foundation
import Alamofire

class APIManager {
	static let shared = APIManager()
	let baseURL: String = secrets.value(forKey: "apiBaseUrl") as! String
	
	let defaultHeaders: HTTPHeaders = [
		"Content-Type": "application/json"
	]
	
	private enum APIRoute: String {
		case user = "/user"
		case chain = "/chain"
	}
	
	func registerUser() {
		let params: Parameters = [
			"data": [
				"name": userName,
				"uid": userNric,
				"nrics": ["1", "2"]
			]
		]
		print("API: Register user with params... \(params)")
		
		self.request(path: .user, params: params, method: .post) {
		}
	}
	
	private func request(path: APIRoute, params: Parameters, method: HTTPMethod, _ callback: @escaping ()->Void) {
		Alamofire.request(baseURL + path.rawValue, method: method, parameters: params, encoding: JSONEncoding.default, headers: [:]).response { dataResponse in
			print("API: Server responded with status code \(dataResponse.response?.statusCode)")
		}
	}

}
