//
//  MockPeopleFailureNetworkManager.swift
//  PeopleTests
//
//  Created by Ifeanyi Onuoha on 07/05/2023.
//

import Foundation
@testable import People

class MockPeopleFailureNetworkManager: NetworkManager {
    var urlSession: URLSession
    
    init(urlSession: URLSession) {
        self.urlSession = urlSession
    }
    
    func request<T>(endpoint: People.Endpoint, type: T.Type) async -> Result<T, Error> where T : Decodable, T : Encodable {
        return .failure(NetworkManagerImpl.NetworkError.invalidData)
    }
    
    func request(endpoint: People.Endpoint) async -> Result<Void, Error> {
        return .success(())
    }
}
