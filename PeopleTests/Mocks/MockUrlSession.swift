//
//  MockUrlSession.swift
//  PeopleTests
//
//  Created by Ifeanyi Onuoha on 05/05/2023.
//

import XCTest

final class MockUrlSession: URLProtocol {

    static var loadingHandler: (() -> (HTTPURLResponse, Data?))?
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        guard let handler = MockUrlSession.loadingHandler else {
            XCTFail("Loading handler has not been set")
            return
        }
        
        let (response, data) = handler()
        
        client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        if let data = data {
            client?.urlProtocol(self, didLoad: data)
        }
        client?.urlProtocolDidFinishLoading(self)
    }
    
    override func stopLoading() {
        
    }
}
