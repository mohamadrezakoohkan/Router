//
//  Request.swift
//  RouterTests
//
//  Created by Mohammad reza Koohkan on 2/9/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import Foundation
import Alamofire
@testable import Router

class Request {
    
    static let managerPy: HTTPManager = {
        let auth = HTTPAuthorization(type: "JWT", credentials: "adjodaddwqiwq")
        let u = HTTPAuthorization(username: <#T##String#>, password: <#T##String#>)
        let head: HTTPHeaders = ["shit": "pussy"]
       let manager = HTTPManager(httpAuthorization: auth,
                                 httpHeader: head,
                                 httpDomains: [Domain.github])
        return manager
    }()
    
    static let shared = Request.init()
    
    let dictionaryRequest = {
        return managerPy.request(endpoint: Endpoint.dictionary)
    }()
    
    let collectionRequest = {
        return HTTPRequest(endpoint: Endpoint.collection)
    }()
    
    let stringRequest = {
        return HTTPRequest(endpoint: Endpoint.string)
    }()
    
    let boolRequest = {
        return HTTPRequest(endpoint: Endpoint.bool)
    }()
    
    let intRequest = {
        return HTTPRequest(endpoint: Endpoint.int)
    }()
    
    let stringRequest2 = {
        return HTTPRequest(endpoint: Endpoint.string2)
    }()
    
    let carRequest = {
        return HTTPRequest(endpoint: Endpoint.car)
    }()
    
    let factoriesRequest = {
        return HTTPRequest(endpoint: Endpoint.factories)
    }()
    
    let peopleRequest = { (id: Int?) in
        return HTTPRequest(endpoint: Endpoint.people(id))
    }
    
    let todosRequest = { (id: Int?) in
        return HTTPRequest(endpoint: Endpoint.todos(id))
    }
    
}
