//
//  Endpoint.swift
//  RouterTests
//
//  Created by Mohammad reza Koohkan on 2/8/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import Foundation
@testable import Router


enum Endpoint: HTTPEndpoint {
        
 
    case dictionary
    case collection
    case string
    case bool
    case int
    
    var endpoint: String {
        switch self {
        case .dictionary:
            return "Router/cloud/dictionary.json"
        case .collection:
            return "Router/cloud/collection.txt"
        case .string:
            return "Router/cloud/string"
        case .bool:
            return "Router/cloud/bool"
        case .int:
            return "Router/cloud/int"
        }
    }
    
    var resolve: EndpointScheme {
        return .init(domain: Domain.github.resolve, endpoint: self.endpoint)
    }
    
    
}
