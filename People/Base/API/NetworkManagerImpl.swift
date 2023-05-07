//
//  NetworkingManagerImpl.swift
//  People
//
//  Created by Ifeanyi Onuoha on 06/05/2023.
//

import Foundation


final class NetworkManagerImpl: NetworkManager {
    static let shared = NetworkManagerImpl()
    
    var urlSession: URLSession
    
    private init(urlSession: URLSession = URLSession(configuration: .ephemeral)) {
        self.urlSession = urlSession
    }
    
    func request<T: Codable>(endpoint: Endpoint, type: T.Type) async -> Result<T, Error> {
        do {
            guard let url = endpoint.url else {
                return .failure(NetworkError.invalidUrl)
            }
            
            let request = buildRequest(url: url, methodType: endpoint.type)
            
            let (data, response) = try await urlSession.data(for: request)
            
            guard let response = response as? HTTPURLResponse, (200...300) ~= response.statusCode else {
                return .failure(NetworkError.invalidResponse)
            }
            
            guard let res: T = try? JSONMapper.decode(data) else {
                return .failure(NetworkError.invalidData)
            }
            
            return .success(res)
        } catch {
            return .failure(NetworkError.defaultError(error: error))
        }
    }
    
    func request(endpoint: Endpoint) async -> Result<Void, Error> {
        do {
            guard let url = endpoint.url else {
                return .failure(NetworkError.invalidUrl)
            }
            
            let request = buildRequest(url: url, methodType: endpoint.type)
            
            let (_, response) = try await urlSession.data(for: request)
            
            guard let response = response as? HTTPURLResponse, (200...300) ~= response.statusCode else {
                return .failure(NetworkError.invalidResponse)
            }
            
            return .success(())
        } catch {
            return .failure(NetworkError.defaultError(error: error))
        }
    }
}

extension NetworkManagerImpl {
    enum NetworkError: LocalizedError, Equatable {
        static func == (lhs: NetworkManagerImpl.NetworkError, rhs: NetworkManagerImpl.NetworkError) -> Bool {
            lhs.compare == rhs.compare
        }
        
        case defaultError(error: Error)
        case invalidUrl
        case invalidResponse
        case invalidData
        
        private var compare: String? {
            switch self {
            case .defaultError:
                return "default"
            case .invalidUrl:
                return "Invalid url"
            case .invalidResponse:
                return "Invalid response"
            case .invalidData:
                return "Invalid data"
            }
        }
    }
}

extension NetworkManagerImpl.NetworkError {
    var errorDescription: String? {
        switch self {
        case .defaultError(let error):
            return "An error occured: \(error.localizedDescription)"
        case .invalidUrl:
            return "Invalid url error"
        case .invalidResponse:
            return "Invalid response error"
        case .invalidData:
            return "Invalid data error"
        }
    }
}


private extension NetworkManagerImpl {
    func buildRequest(url: URL, methodType: Endpoint.MethodType) -> URLRequest {
        var request = URLRequest(url: url)
        
        do {
            switch methodType {
                
            case .get:
                request.httpMethod = "GET"
            case .post(let data):
                request.httpMethod = "POST"
                
                guard let data = data else {
                    return request
                }
                let postData = try JSONMapper.encode(data)
                request.httpBody = postData
            }
        } catch {
            print(error)
        }
        return request
    }
}
