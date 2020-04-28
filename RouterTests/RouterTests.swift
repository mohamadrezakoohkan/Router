//
//  RouterTests.swift
//  RouterTests
//
//  Created by Mohammad reza Koohkan on 2/8/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import XCTest
@testable import Router

extension String {
    var bool: Bool { self == "1" || self == "true" || self == "True" || self == "yes" }
}

class RouterTests: XCTestCase {
    
    let sut = Request.shared
    let bool = try! String(contentsOf: Bundle.main.url(forResource: "bool", withExtension: nil)!, encoding: .utf8)
    let int = try! String(contentsOf: Bundle.main.url(forResource: "int", withExtension: nil)!, encoding: .utf8)
    let string = try! String(contentsOf: Bundle.main.url(forResource: "string", withExtension: nil)!, encoding: .utf8)
    
    let dictionary: [String: Any] = {
        let file = Bundle.main.url(forResource: "dictionary", withExtension: "json")!
        let string = try! String(contentsOf: file, encoding: .utf8)
        let data = string.data(using: .utf8)!
        let json = try! JSONSerialization.jsonObject(with: data, options: .allowFragments)
        return json as! [String: Any]
    }()
    
    let collection: [Double] = {
        let file = Bundle.main.url(forResource: "collection", withExtension: "txt")!
        let string = try! String(contentsOf: file, encoding: .utf8)
        let data = string.data(using: .utf8)!
        let json = try! JSONSerialization.jsonObject(with: data, options: .allowFragments)
        return json as! [Double]
    }()
        
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testDict() {
        let expectations = expectation(description: "Expect to get \(self.dictionary)")
        let request = self.sut.dictionaryRequest.testInformation()
        request.response { (json: [String: Any]?) in
            guard json?["test"] as? Bool == self.dictionary["test"] as? Bool
                else { XCTFail("Fail \(json ?? [:])"); return }
            expectations.fulfill()
        }
        wait(for: [expectations], timeout: 30)
    }
    
    func testCollection() {
        let expectations = expectation(description: "Expect to get \(self.collection.last ?? -1)")
        let request = self.sut.collectionRequest.testInformation()
        request.response { (collection: [Double]?) in
            guard collection?.last == self.collection.last
                else { XCTFail("Fail \(collection ?? [])"); return }
            expectations.fulfill()
        }
        wait(for: [expectations], timeout: 30)
    }
    
    func testString() {
        let expectations = expectation(description: "Expect to get \(self.string)")
        let request = self.sut.stringRequest.testInformation()
        request.response { (value: String?) in
            guard value == self.string
                else { XCTFail("Fail \(self.string)"); return }
            expectations.fulfill()
        }
        wait(for: [expectations], timeout: 30)
    }
    
    func testBool() {
        let expectations = expectation(description: "Expect to get \(self.bool.bool)")
        let request = self.sut.stringRequest.testInformation()
        request.response { (value: String?) in
            guard value?.bool == self.bool.bool
                else { XCTFail("Fail \(self.string)"); return }
            expectations.fulfill()
        }
        wait(for: [expectations], timeout: 30)
    }

    
}
