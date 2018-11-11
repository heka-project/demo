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
	
	let defaultParams: Parameters = [:]
	let defaultHeaders: HTTPHeaders = [
		"Accept": "application/json"
	]
	
	private enum APIRoute: String {
		case user = "/user"
	}
	
	private func request(path: APIRoute, method: HTTPMethod, _ callback: @escaping ()->Void) {
		Alamofire.request(baseURL + path.rawValue, method: method, parameters: [:], encoding: URLEncoding.default, headers: [:])
			.responseJSON { response in
		}
	}

}
