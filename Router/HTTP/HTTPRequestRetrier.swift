//
//  HTTPRequestRetrier.swift
//  Router
//
//  Created by Mohammad reza Koohkan on 2/9/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import Foundation
import Alamofire

public struct HTTPRequestRetrier: RequestInterceptor {
    
    public init() {

    }
    
    public func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        completion(.success(urlRequest))
    }
    
    public func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        switch error.asAFError {
        case .requestRetryFailed(retryError: _, originalError: _),
             .explicitlyCancelled,
             .serverTrustEvaluationFailed(reason: _),
             .invalidURL(url: _):
            completion(.doNotRetry)
        default:
            completion(.retry)
        }
        
    }
}
