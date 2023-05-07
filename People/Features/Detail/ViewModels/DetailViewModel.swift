//
//  DetailViewModel.swift
//  People
//
//  Created by Ifeanyi Onuoha on 01/05/2023.
//

import Foundation

final class DetailViewModel: ObservableObject {
    private var personDetail: PersonDetail?
    @Published private(set) var user: Person?
    @Published var hasError = false
    @Published private(set) var state: DetailState?
    @Published private(set) var error: NetworkManagerImpl.NetworkError?
    
    @MainActor
    func fetchPerson(for id: Int) async {
        self.state = .loading
        defer { self.state = .idle }
        
        let res = await NetworkManagerImpl.shared.request(endpoint: .detail(id: id), type: PersonDetail.self)
        
        switch res {
        case .success(let response):
            self.personDetail = response
            self.user = response.data
        case .failure(let error):
            self.hasError = true
            if let networkingError = error as? NetworkManagerImpl.NetworkError {
                self.error = networkingError
            } else {
                self.error = .defaultError(error: error)
            }
        }
    }
}

extension DetailViewModel {
    enum DetailState {
        case idle
        case loading
    }
}
