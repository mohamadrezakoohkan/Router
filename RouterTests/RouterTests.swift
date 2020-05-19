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
    let bool = true
    let int = 12300
    let string = "Hello world!"
    let string2 = "Hello world"
    let dictionary = ["test": 100]
    let collection: [Double] = [13.213,123.1,63.1,3.14]
    
    func testDict() {
        let expectations = expectation(description: "Expect to get \(self.dictionary)")
        let request = self.sut.dictionaryRequest.testInformation()
        request.response { (json: [String: Any]?) in
            guard json?["test"] as? Int == self.dictionary["test"]
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
    
    func testString2() {
        let expectations = expectation(description: "Expect to get \(self.string)")
        let request = self.sut.stringRequest2.testInformation()
        request.response { (value: String?) in
            guard value == self.string2
                else { XCTFail("Fail \(self.string)"); return }
            expectations.fulfill()
        }
        wait(for: [expectations], timeout: 30)
    }
    
    func testBool() {
        let expectations = expectation(description: "Expect to get \(self.bool)")
        let request = self.sut.boolRequest.testInformation()
        request.response { (value: Bool?) in
            guard value == self.bool
                else { XCTFail("Fail \(self.string)"); return }
            expectations.fulfill()
        }
        wait(for: [expectations], timeout: 30)
    }
    
    func testCar() {
        let expectations = expectation(description: "Expect to get a car")
        let request = self.sut.carRequest.testInformation()
        request.response(decodable: Car.self) { (car) in
            guard let _car = car else {
                XCTFail("Fail car is nil")
                return
            }
            print(_car)
            expectations.fulfill()
        }
        wait(for: [expectations], timeout: 30)
    }

    func testFactory() {
        let expectations = expectation(description: "Expect to get a list of factories")
        let request = self.sut.factoriesRequest.testInformation()
        request.response(decodable: [Factory].self) { (factories) in
            guard let _factories = factories else {
                XCTFail("Fail car is nil")
                return
            }
            print(_factories)
            expectations.fulfill()
        }
        wait(for: [expectations], timeout: 30)
    }
    
    func testPeople() {
        let expectations = expectation(description: "Expect to get a people")
        let request = self.sut.peopleRequest(1).testInformation()
        request.response(decodable: People.self) { (result) in
            guard let _result = result else {
                XCTFail("Fail car is nil")
                return
            }
            print(_result)
            expectations.fulfill()
        }
        wait(for: [expectations], timeout: 30)
    }
    
    func testTodo() {
        let expectations = expectation(description: "Expect to get a list of todos")
        let request = self.sut.todosRequest(nil).testInformation()
        request.response(decodable: [Todo].self) { (result) in
            guard let _result = result else {
                XCTFail("Fail car is nil")
                return
            }
            print(_result)
            expectations.fulfill()
        }
        wait(for: [expectations], timeout: 30)
    }
}
