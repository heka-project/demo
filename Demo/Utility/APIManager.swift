
//  APIManager.swift
//  Demo
//
//  Created by Sean Lim on 11/11/18.
//  Copyright © 2018 Heka. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class APIManager {
	static let shared = APIManager()
	let baseURL: String = secrets.value(forKey: "api_base_url") as! String
	
	let defaultHeaders: HTTPHeaders = [
		"Content-Type": "application/json",
		"Authorization": secrets.value(forKey: "api_secret") as! String
	]
	
	private enum APIRoute: String {
		case user = "/user"
		case chain = "/chain"
	}
	
	func updateUser(callback: @escaping (_ succ: Bool) -> Void) {
		let params: Parameters = [
			"data": [
				"name": userName,
				"uid": userNric,
				"nrics": ["1", "2"]
			]
		]
		print("API: Register user with params... \(params)")
		
		self.request(path: .user, params: params, method: .post) { (succ, res) in
			if !succ {
				print("API: User account failed to update/register")
			}
			callback(succ)
		}
	}
	
	func verifyNRIC(nric: String, callback: @escaping (_ isValid: Bool) -> Void ) {
		let params: Parameters = [
			"queryId": nric
		]
		print("API: Verifying user with params ... \(params)")
		self.request(path: .user, params: params, method: .get) { (succ, res) in
			if succ {
				if let uid = res?.dictionaryValue["0"]?.dictionaryObject!["uid"] {
					print("API: User with UID \(uid) already exists")
					callback(false)
				} else {
					callback(true)
				}
			} else {
				fatalError("API: Failed to verify NRIC")
			}
		}
	}
	
	func updateChainState() {
		let params: Parameters = [
			"chain": [
				"batch_id": "batch_1",
				"nodes": P2PManager.service.fragmentCache!.nodes,
				"md5": P2PManager.service.fragmentCache!.md5 as Any
			]
		]
		print("sending request with param \(params)")
		self.request(path: .chain, params: params, method: .post) { (succ, data ) in
			if !succ {
				fatalError()
			}
		}
	}

	private func request(path: APIRoute,
						 params: Parameters,
						 method: HTTPMethod,
						 _ callback: @escaping (_ success: Bool, _ response: JSON?) -> Void) {
		Alamofire
			.request(baseURL + path.rawValue,
						  method: method,
						  parameters: params,
						  encoding: (method == .get ? URLEncoding.default: JSONEncoding.default),
						  headers:  self.defaultHeaders)
			.response { dataResponse in
				if let response = dataResponse.response, let data = dataResponse.data  {
					print("API: Server responded with status code \(response.statusCode)")
					let jsonData = try? JSON(data: data)
					callback(true, jsonData)
				} else {
					callback(false, nil)
				}
			}
	}

}
