//
//  RequestFactory.swift
//  CanadaPOC
//
//  Created by Admin on 3/26/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

// Request method type
struct RequestFactory {
    
    enum Method: String {
        case GET
        case POST
        case PUT
        case DELETE
        case PATCH
    }
    // create Request
    static func request(method: Method, url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        return request
    }
    
    
}
