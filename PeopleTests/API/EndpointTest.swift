//
//  EndpointTest.swift
//  PeopleTests
//
//  Created by Ifeanyi Onuoha on 05/05/2023.
//

import XCTest
@testable import People

final class EndpointTest: XCTestCase {

    func testPeopleEndpointCase() {
        let endpoint = Endpoint.people(page: 1)
        
        XCTAssertEqual(endpoint.path, "/api/users")
        XCTAssertEqual(endpoint.type, .get)
        XCTAssertEqual(endpoint.queryItems, ["page": "1"])
        XCTAssertEqual(endpoint.url?.absoluteString, "https://reqres.in/api/users?page=1&delay=1")
    }
    
    func testDetailEndpointCase() {
        let endpoint = Endpoint.detail(id: 22)
        
        XCTAssertEqual(endpoint.path, "/api/users/22")
        XCTAssertEqual(endpoint.type, .get)
        XCTAssertEqual(endpoint.queryItems, [:])
        XCTAssertEqual(endpoint.url?.absoluteString, "https://reqres.in/api/users/22?delay=1")
    }
    
    func testCreateEndpointCase() {
        let person = NewPerson(firstName: "first", lastName: "last", job: "developer")
        let endpoint = Endpoint.create(data: person)
        
        XCTAssertEqual(endpoint.path, "/api/users")
        XCTAssertEqual(endpoint.type, .post(data: person))
        XCTAssertEqual(endpoint.queryItems, [:])
        XCTAssertEqual(endpoint.url?.absoluteString, "https://reqres.in/api/users?delay=1")
    }
}
