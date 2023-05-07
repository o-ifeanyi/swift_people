//
//  CreateValidatorTest.swift
//  PeopleTests
//
//  Created by Ifeanyi Onuoha on 05/05/2023.
//

import Foundation
import XCTest
@testable import People

class CreateValidatorTest: XCTestCase {
    func testValidNewPersonCase() {
        let person = NewPerson(firstName: "first", lastName: "last", job: "developer")
        
        XCTAssertNil(CreateValidator.validatePerson(person))
    }
    
    func testInvalidFirstNameCase() {
        let person = NewPerson(firstName: "", lastName: "last", job: "developer")
        
        let response = CreateValidator.validatePerson(person)
        
        XCTAssertNotNil(response)
        XCTAssertEqual(response as? CreateValidator.PersonValidator, CreateValidator.PersonValidator.invalidFirstName)
    }
    
    func testInvalidLastNameCase() {
        let person = NewPerson(firstName: "first", lastName: "", job: "developer")
        
        let response = CreateValidator.validatePerson(person)
        
        XCTAssertNotNil(response)
        XCTAssertEqual(response as? CreateValidator.PersonValidator, CreateValidator.PersonValidator.invalidLastName)
    }
    
    func testInvalidJobCase() {
        let person = NewPerson(firstName: "first", lastName: "last", job: "")
        
        let response = CreateValidator.validatePerson(person)
        
        XCTAssertNotNil(response)
        XCTAssertEqual(response as? CreateValidator.PersonValidator, CreateValidator.PersonValidator.InvalidJob)
    }
}
