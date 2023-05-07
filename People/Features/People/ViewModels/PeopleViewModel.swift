//
//  PeopleViewModel.swift
//  People
//
//  Created by Ifeanyi Onuoha on 30/04/2023.
//

import Foundation

final class PeopleViewModel: ObservableObject {
    private var networkManager: NetworkManager!
    
    init(networkManager: NetworkManager = NetworkManagerImpl.shared) {
        self.networkManager = networkManager
    }
    
    
    
    @Published private(set) var people: [Person] = []
    @Published var hasError = false
    @Published private(set) var state: PeopleState?
    @Published private(set) var error: NetworkManagerImpl.NetworkError?
    
    private(set) var page: Int = 0
    private(set) var totalPages: Int = 1
    
    @MainActor
    func fetchPeople(shouldReset: Bool = false) async {
        if shouldReset { reset() }
        guard page != totalPages else { return }
        page += 1
        
        if page == 1 {
            self.state = .loading
        } else {
            self.state = .fetchingMore
        }
        
        defer { self.state = .idle }
        
        let res = await networkManager.request(
            endpoint: .people(page: page),
            type: PaginatedData<[Person]>.self
        )
        
        switch res {
        case .success(let response):
            self.totalPages = response.totalPages
            self.people += response.data
        case .failure(let error):
            self.hasError = true
            if let networkingError = error as? NetworkManagerImpl.NetworkError {
                self.error = networkingError
            } else {
                self.error = .defaultError(error: error)
            }
        }
    }
    
    func hasReachedEnd(of person: Person) -> Bool {
        self.people.last?.id == person.id
    }
    
    func reset() {
        self.people.removeAll()
        self.page = 0
        self.totalPages = 1
        self.state = nil
        self.error = nil
    }
}


extension PeopleViewModel {
    enum PeopleState {
        case idle
        case loading
        case fetchingMore
    }
}
