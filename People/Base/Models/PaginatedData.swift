//
//  PaginatedData.swift
//  People
//
//  Created by Ifeanyi Onuoha on 28/04/2023.
//

import Foundation

struct PaginatedData<T: Codable & Equatable>: Codable, Equatable {
    static func == (lhs: PaginatedData<T>, rhs: PaginatedData<T>) -> Bool {
        return lhs.page == rhs.page && lhs.perPage == rhs.perPage && lhs.total == rhs.total && lhs.totalPages == rhs.totalPages && lhs.data == rhs.data
    }
    
    let page: Int
    let perPage: Int
    let total: Int
    let totalPages: Int
    let support: Support
    let data: T
}
