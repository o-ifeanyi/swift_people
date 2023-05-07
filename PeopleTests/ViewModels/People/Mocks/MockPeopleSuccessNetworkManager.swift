//
//  MockSuccessNetworkManager.swift
//  PeopleTests
//
//  Created by Ifeanyi Onuoha on 07/05/2023.
//

import Foundation
@testable import People

class MockPeopleSuccessNetworkManager: NetworkManager {
    var urlSession: URLSession
    
    init(urlSession: URLSession) {
        self.urlSession = urlSession
    }
    
    func request<T>(endpoint: People.Endpoint, type: T.Type) async -> Result<T, Error> where T : Decodable, T : Encodable {
        guard let path = Bundle.main.path(forResource: "PeopleJson", ofType: "json"),
              let data = FileManager.default.contents(atPath: path)  else {
            return .failure(NetworkManagerImpl.NetworkError.invalidData)
        }
        
        guard let res: T = try? JSONMapper.decode(data) else {
            return .failure(NetworkManagerImpl.NetworkError.invalidData)
        }
        
        return .success(res)
    }
    
    func request(endpoint: People.Endpoint) async -> Result<Void, Error> {
        return .success(())
    }
}
