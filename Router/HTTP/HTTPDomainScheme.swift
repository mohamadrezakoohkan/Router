//
//  DomainScheme.swift
//  Router
//
//  Created by Mohammad reza Koohkan on 2/8/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import Foundation
import Alamofire

public class HTTPDomainScheme {
    
    
    public let scheme: String
    public let url: URL?
    public let request: URLRequest?
    
    public lazy var hasSSL: Bool = {
        return scheme.contains("https")
    }()
    
    public var isReachable: Bool {
        let reachablitiy = NetworkReachabilityManager(host: self.scheme)
        return reachablitiy?.isReachable == true
    }
    
    public init(scheme: String) {
        self.scheme = scheme
        self.url = URL(string: scheme)
        self.request = url != nil ? URLRequest(url: self.url!) : nil
    }
    
}
