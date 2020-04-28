//
//  HTTPRequest.swift
//  Router
//
//  Created by Mohammad reza Koohkan on 2/9/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import Foundation
import Alamofire

public class HTTPRequest {
    
    public let endpoint: EndpointScheme
    public let method: Alamofire.HTTPMethod
    public let session: Alamofire.Session
    public let header: Alamofire.HTTPHeaders?
    public let body: Alamofire.Parameters?
    public let encoding: HTTPEncodingOptions
    public let retrier: HTTPRequestRetrier?
    public let validationRange: ClosedRange<Int>
    public var request: DataRequest?
    
    
    public init(session: Alamofire.Session = .default,
                endpoint: EndpointScheme,
                method: Alamofire.HTTPMethod = .get,
                header: Alamofire.HTTPHeaders? = nil,
                body: Alamofire.Parameters? = nil,
                encoding: HTTPEncodingOptions = .json,
                retrier: HTTPRequestRetrier? = nil,
                validationRange: ClosedRange<Int> = 0...1000) {

        self.endpoint = endpoint
        self.method = method
        self.session = session
        self.header = header
        self.body = body
        self.encoding = encoding
        self.retrier = retrier
        self.validationRange = validationRange
        _ = self.createRequest()
    }
    
    func testInformation() -> HTTPRequest {
        print("Endpoint:",self.endpoint.urlString)
        print("Method:",self.method.rawValue)
        print("Session:",String(describing: self.session.self))
        print("Header:",self.header ?? [:])
        print("Body:",self.body ?? [:])
        print("Encoding:",String(describing: self.encoding.resolve.self))
        print("ValidationRange:",self.validationRange)
        return self
    }
    
    private func errorHandler(_ err: AFError) {
        
    }
    
    public func createRequest() ->  HTTPRequest {
        self.request = session.request(self.endpoint,
                                       method: self.method,
                                       parameters: self.body,
                                       encoding: self.encoding.resolve,
                                       headers: self.header,
                                       interceptor: self.retrier)
        self.request?.validate(statusCode: self.validationRange)
        return self
    }
    
    
    public func response<T>(_ completion: @escaping (T?) -> Void) {
        guard let req = self.request else {
             print("@HTTP No DataRequest found - first create request using createRequest method")
             completion(nil)
             return
         }
         req.responseJSON { (res) in
             switch res.result {
             case .success(let value):
                 if let result = value as? T {
                     completion(result)
                 }else{
                    print("@HTTP \(self.endpoint.urlString) not retriving \(T.self) but getting: \(value)")
                     completion(nil)
                 }
             case .failure(let error):
                 self.errorHandler(error)
             }
         }
    }
    
    public func json(_ completion: @escaping ([String: Any]) -> Void) {
        guard let req = self.request else {
            print("@HTTP No DataRequest found")
            completion([:])
            return
        }
        req.responseJSON { (res) in
            switch res.result {
            case .success(let value):
                if let json = value as? [String: Any] {
                    completion(json)
                }else{
                    print("@HTTP \(self.endpoint.urlString) not retriving json but getting: \(value)")
                    completion([:])
                }
            case .failure(let error):
                self.errorHandler(error)
            }
        }
    }
    
    public func jsonCollection(_ completion: @escaping ([[String: Any]]) -> Void) {
        guard let req = self.request else {
            print("@HTTP No DataRequest found")
            completion([])
            return
        }
        req.responseJSON { (res) in
            switch res.result {
            case .success(let value):
                if let collection = value as? [[String: Any]] {
                    completion(collection)
                }else{
                    print("@HTTP \(self.endpoint.urlString) not retriving json collection but getting: \(value)")
                    completion([])
                }
            case .failure(let error):
                self.errorHandler(error)
            }
        }
    }
    
}

