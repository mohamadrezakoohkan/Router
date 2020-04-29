//
//  Request.swift
//  RouterTests
//
//  Created by Mohammad reza Koohkan on 2/9/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import Foundation
@testable import Router

class Request {
    
    static let shared = Request.init()
    
    let dictionaryRequest = {
        return HTTPRequest(endpoint: Endpoint.dictionary.resolve)
    }()
    
    let collectionRequest = {
        return HTTPRequest(endpoint: Endpoint.collection.resolve)
    }()
    
    let stringRequest = {
        return HTTPRequest(endpoint: Endpoint.string.resolve)
    }()
    
    let boolRequest = {
        return HTTPRequest(endpoint: Endpoint.bool.resolve)
    }()
    
    let intRequest = {
        return HTTPRequest(endpoint: Endpoint.int.resolve)
    }()
    
    let stringRequest2 = {
        return HTTPRequest(endpoint: Endpoint.string2.resolve)
    }()
}
