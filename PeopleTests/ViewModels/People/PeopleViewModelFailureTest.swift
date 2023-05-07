//
//  PeopleViewModelFailureTest.swift
//  PeopleTests
//
//  Created by Ifeanyi Onuoha on 07/05/2023.
//

import XCTest
@testable import People

final class PeopleViewModelFailureTest: XCTestCase {
    private var networkManager: NetworkManager!
    private var urlSession: URLSession!
    private var vm: PeopleViewModel!
    
    override func setUp() {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockUrlSession.self]
        
        urlSession = URLSession(configuration: configuration)
        networkManager = MockPeopleFailureNetworkManager(urlSession: urlSession)
        vm = PeopleViewModel(networkManager: networkManager)
    }
    
    override func tearDown() {
        networkManager = nil
        urlSession = nil
        vm = nil
    }

    func test_fechPeople_failure_case() async {
        XCTAssertNil(vm.state)
        XCTAssertNil(vm.error)
        XCTAssertFalse(vm.hasError)
        
        await vm.fetchPeople()
        
        XCTAssertTrue(vm.state == .idle)
        XCTAssertNotNil(vm.error)
        XCTAssertTrue(vm.error == .invalidData)
        XCTAssertTrue(vm.hasError)
    }
}
