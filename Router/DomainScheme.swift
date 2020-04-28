//
//  DomainScheme.swift
//  Router
//
//  Created by Mohammad reza Koohkan on 2/8/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import Foundation
import Alamofire

public class DomainScheme {
    
    public let scheme: String
    public let url: URL?
    public let request: URLRequest?
    
    public lazy var hasSSL: Bool = {
        return scheme.contains("https")
    }()
    
    public init(scheme: String) {
        self.scheme = scheme
        self.url = URL(string: scheme)
        self.request = url != nil ? URLRequest(url: self.url!) : nil
    }
    
    
    public func isReachable(_ completion: @escaping (Bool) -> Void) {
        guard let request = self.request else { return }
        URLSession.shared.dataTask(with: request) { data, response, error in
            print(error?.localizedDescription ?? "\(self.scheme) is reachable")
            error == nil ? completion(true) : completion(false)
        }.resume()
    }
    
}
