//
//  CreateValidator.swift
//  People
//
//  Created by Ifeanyi Onuoha on 03/05/2023.
//

import Foundation

struct CreateValidator {
    
    static func validatePerson(_ person: NewPerson) -> Error?  {
        if person.firstName.isEmpty {
            return CreateValidator.PersonValidator.invalidFirstName
        }
        
        if person.lastName.isEmpty {
            return CreateValidator.PersonValidator.invalidLastName
        }
        
        if person.job.isEmpty {
            return CreateValidator.PersonValidator.InvalidJob
        }
        
        return nil
    }
}

extension CreateValidator {
    enum PersonValidator: LocalizedError {
        case invalidFirstName
        case invalidLastName
        case InvalidJob
    }
}

extension CreateValidator.PersonValidator {
    var errorDescription: String? {
        switch self {
            
        case .invalidFirstName:
            return "First name cannot be blank"
        case .invalidLastName:
            return "Last name cannot be blank"
        case .InvalidJob:
            return "Job cannot be blank"
        }
    }
}
