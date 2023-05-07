//
//  Endpoints.swift
//  People
//
//  Created by Ifeanyi Onuoha on 03/05/2023.
//

import Foundation

enum Endpoint {
    case people(page: Int)
    case detail(id: Int)
    case create(data: Codable?)
}

extension Endpoint {
    enum MethodType: Equatable {
        static func == (lhs: Endpoint.MethodType, rhs: Endpoint.MethodType) -> Bool {
            lhs.comparisonValue == rhs.comparisonValue
        }
        
        case get
        case post(data: Codable?)
        
        private var comparisonValue: String {
          switch self {
          case .get:
              return "get"
          case .post:
              return "post"
          }
        }
    }
}

extension Endpoint {
    var path: String {
        switch self {
        case .people, .create:
            return "/api/users"
        case .detail(let id):
            return "/api/users/\(id)"
        }
    }
    
    var type: MethodType {
        switch self {
        case .people, .detail:
            return .get
        case .create(let data):
            return .post(data: data)
        }
    }
    
    var queryItems: [String: String] {
        switch self {
        case .people(let page):
            return ["page": "\(page)"]
        default:
            return [:]
        }
    }
}

extension Endpoint {
    var url: URL? {
        var urlComponent = URLComponents()
        urlComponent.scheme = "https"
        urlComponent.host = "reqres.in"
        urlComponent.path = path
        
        var queryParameters = queryItems.compactMap { item in
            URLQueryItem(name: item.key, value: item.value)
        }
        
        queryParameters.append(URLQueryItem(name: "delay", value: "1"))
        
        urlComponent.queryItems = queryParameters
        
        return urlComponent.url
    }
}

