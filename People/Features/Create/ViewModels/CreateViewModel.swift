//
//  CreateViewModel.swift
//  People
//
//  Created by Ifeanyi Onuoha on 01/05/2023.
//

import SwiftUI

final class CreateViewModel: ObservableObject {
    @Published var newPerson = NewPerson()
    @Published private(set) var state: CreateState?
    @Published var hasError = false
    @Published private(set) var error: NetworkManagerImpl.NetworkError?
    
    @MainActor
    func createPerson() async {
        self.state = .loading
        
        let res = await NetworkManagerImpl.shared.request(endpoint: .create(data: newPerson))
        
        switch res {
        case .success:
            self.state = .success
        case .failure(let error):
            self.state = .failure
            self.hasError = true
            if let networkingError = error as? NetworkManagerImpl.NetworkError {
                self.error = networkingError
            } else {
                self.error = .defaultError(error: error)
            }
        }
    }
}

extension CreateViewModel {
    enum CreateState: Equatable {
        case success
        case failure
        case loading
    }
}
