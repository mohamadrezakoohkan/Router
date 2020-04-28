//
//  EndpointScheme.swift
//  Router
//
//  Created by Mohammad reza Koohkan on 2/8/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import Foundation
import Alamofire

protocol HTTPEndpoint {
    var resolve: EndpointScheme { get }
    func add(to url: String, _ parameter: Any?) -> String
}

extension HTTPEndpoint {
    func add(to url: String, _ parameter: Any?) -> String {
        return "\(url)\(parameter == nil ? "" : "\(parameter!)/")"
    }
}

public class EndpointScheme: URLConvertible {
    
    public let domain: DomainScheme
    public let endpoint: String
    public let urlString: String
    public let url: URL?
    
    public init(domain: DomainScheme, endpoint: String) {
        self.domain = domain
        self.endpoint = endpoint
        self.urlString = domain.scheme + endpoint
        self.url = URL(string: self.urlString)
    }
    
    public func asURL() throws -> URL {
        if let _url = self.url {
            return _url
        }else{
            throw AFError.invalidURL(url: domain.scheme + endpoint)
        }
    }
    
}
