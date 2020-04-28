//
//  Domain.swift
//  RouterTests
//
//  Created by Mohammad reza Koohkan on 2/8/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import Foundation
@testable import Router

enum Domain {
    
    static let current = Domain.github
    
    case github
    
    case custom(String)
    
    var resolve: DomainScheme {
        switch self {
        case .github:
            return .init(scheme: "https://raw.githubusercontent.com/mohamadrezakoohkan/Router/master/")
        case .custom(let domain):
            return .init(scheme: domain)
        }
    }
    
    
}
