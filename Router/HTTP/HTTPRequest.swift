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
    
    public let endpoint: HTTPEndpoint
    public let method: Alamofire.HTTPMethod
    public let session: HTTPSession
    public let header: Alamofire.HTTPHeaders?
    public let body: Alamofire.Parameters?
    public let encoding: HTTPEncodingOptions
    public let validationRange: ClosedRange<Int>
    public var request: DataRequest?
    
    
    public init(session: HTTPSession = .shared,
                endpoint: HTTPEndpoint,
                method: Alamofire.HTTPMethod = .get,
                header: Alamofire.HTTPHeaders? = nil,
                body: Alamofire.Parameters? = nil,
                encoding: HTTPEncodingOptions = .json,
                validationRange: ClosedRange<Int> = 0...1000) {

        self.endpoint = endpoint
        self.method = method
        self.session = session
        self.header = header
        self.body = body
        self.encoding = encoding
        self.validationRange = validationRange
        _ = self.createRequest()
    }
    
    public func testInformation() -> HTTPRequest {
        print("Endpoint:",self.endpoint.resolve.urlString)
        print("Method:",self.method.rawValue)
        print("Session:",String(describing: self.session.self))
        print("Header:",self.header ?? [:])
        print("Body:",self.body ?? [:])
        print("Encoding:",String(describing: self.encoding.resolve.self))
        print("ValidationRange:",self.validationRange)
        return self
    }
    
    private func errorHandler(_ err: AFError) {
        print(err.localizedDescription)
    }
    
    public func createRequest() ->  HTTPRequest {
        self.request = session.request(self.endpoint.resolve,
                                       method: self.method,
                                       parameters: self.body,
                                       encoding: self.encoding.resolve,
                                       headers: self.header)
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
                    print("@HTTP \(self.endpoint.resolve.urlString) not retriving \(T.self) but getting: \(value)")
                     completion(nil)
                 }
             case .failure(let error):
                 self.errorHandler(error)
                completion(nil)
             }
         }
    }
    
    public func response<T: Decodable>(decodable: T.Type,
                                     decoder: JSONDecoder = JSONDecoder(),
                       _ completion: @escaping (T?) -> Void) {
        guard let req = self.request else {
            print("@HTTP No DataRequest found - first create request using createRequest method")
            completion(nil)
            return
        }
        req.responseDecodable(of: decodable, decoder: decoder) {
            (response: DataResponse<T,AFError>) in
            switch response.result {
            case .success(let value):
                    completion(value)
            case .failure(let error):
                self.errorHandler(error)
               completion(nil)
            }
        }
    }
}

