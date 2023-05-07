//
//  NetworkingManagerTest.swift
//  PeopleTests
//
//  Created by Ifeanyi Onuoha on 05/05/2023.
//


import XCTest
@testable import People

final class NetworkManagerTest: XCTestCase {
    
    private var session: URLSession!
    private var url: URL!
    private var networkManager: NetworkManagerImpl!
    
    override func setUp() {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockUrlSession.self]
        
        session = URLSession(configuration: configuration)
        url = URL(string: "https://reqres.in/api/users")!
        
        networkManager = NetworkManagerImpl.shared
        networkManager.urlSession = session
    }
    
    override func tearDown() {
        session = nil
        url = nil
        networkManager = nil
    }

    
    func testSuccessfulResponseCase() async {
        guard let path = Bundle.main.path(forResource: "PeopleJson", ofType: "json"),
              let data = FileManager.default.contents(atPath: path)  else {
            XCTFail("Failed to locate PeopleJson in bundle")
            return
        }
        
        MockUrlSession.loadingHandler = {
            let res = HTTPURLResponse(url: self.url, statusCode: 200, httpVersion: nil, headerFields: nil)
            
            return (res!, data)
        }
        
        let res = await networkManager.request(endpoint: .people(page: 1), type: PaginatedData<[Person]>.self)
        
        do {
            switch res {
            case .success(let response):
                let expected: PaginatedData<[Person]> = try JSONMapper.decode(data)
                XCTAssertEqual(response, expected)
            case .failure(let failure):
                XCTFail("request should be successful: \(failure.localizedDescription)")
            }
        } catch {
            XCTFail("request should be successful: \(error.localizedDescription)")
        }
    }
    
    func testInvalidDataCase() async {
        MockUrlSession.loadingHandler = {
            let res = HTTPURLResponse(url: self.url, statusCode: 200, httpVersion: nil, headerFields: nil)
            
            return (res!, nil)
        }
        
        let res = await networkManager.request(endpoint: .people(page: 1), type: PaginatedData<[Person]>.self)
        
        switch res {
        case .success:
            XCTFail("request should fail")
        case .failure(let failure):
            if let networkingError = failure as? NetworkManagerImpl.NetworkError {
                XCTAssertEqual(networkingError, .invalidData)
            }
        }
    }
    
    func testInvalidResponseCase() async {
        MockUrlSession.loadingHandler = {
            let res = HTTPURLResponse(url: self.url, statusCode: 400, httpVersion: nil, headerFields: nil)
            
            return (res!, nil)
        }
        
        let res = await networkManager.request(endpoint: .people(page: 1), type: PaginatedData<[Person]>.self)
        
        switch res {
        case .success:
            XCTFail("request should fail")
        case .failure(let failure):
            if let networkingError = failure as? NetworkManagerImpl.NetworkError {
                XCTAssertEqual(networkingError, .invalidResponse)
            }
        }
    }
}
