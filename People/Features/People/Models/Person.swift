//
//  Person.swift
//  People
//
//  Created by Ifeanyi Onuoha on 28/04/2023.
//

import Foundation

struct Person: Codable, Identifiable, Equatable {
    let id: Int
    let email: String
    let firstName: String
    let lastName: String
    let avatar: String
}
