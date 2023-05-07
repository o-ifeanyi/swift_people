//
//  PersonTest.swift
//  PeopleTests
//
//  Created by Ifeanyi Onuoha on 05/05/2023.
//

import Foundation
import XCTest
@testable import People

class PersonTest: XCTestCase {
    func testDecodeValidJsonCase() {
        guard let path = Bundle.main.path(forResource: "PersonJson", ofType: "json"),
              let data = FileManager.default.contents(atPath: path)  else {
            XCTFail("Failed to locate PersonJson in bundle")
            return
        }
        
        XCTAssertNoThrow(try JSONMapper.decode(data) as Person)
    }
    
    func testDecodeInvalidJsonCase() {
        XCTAssertThrowsError(try JSONMapper.decode(Data()) as Person)
    }
    
    func testEncodeValidJsonCase() {
        let person = Person(id: 1, email: "email", firstName: "first", lastName: "last", avatar: "avatar")
        
        XCTAssertNoThrow(try JSONMapper.encode(person) as Data)
    }
}
