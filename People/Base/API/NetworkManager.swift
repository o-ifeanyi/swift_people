//
//  NetworkingManager.swift
//  People
//
//  Created by Ifeanyi Onuoha on 30/04/2023.
//

import Foundation

protocol NetworkManager {
    var urlSession: URLSession { get set }

    func request<T: Codable>(endpoint: Endpoint, type: T.Type) async -> Result<T, Error>
    
    func request(endpoint: Endpoint) async -> Result<Void, Error>
}
