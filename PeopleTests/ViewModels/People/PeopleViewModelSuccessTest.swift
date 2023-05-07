//
//  PeopleViewModelTest.swift
//  PeopleTests
//
//  Created by Ifeanyi Onuoha on 06/05/2023.
//

import XCTest
@testable import People

final class PeopleViewModelSuccessTest: XCTestCase {
    private var networkManager: NetworkManager!
    private var urlSession: URLSession!
    private var vm: PeopleViewModel!
    
    override func setUp() {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockUrlSession.self]
        
        urlSession = URLSession(configuration: configuration)
        networkManager = MockPeopleSuccessNetworkManager(urlSession: urlSession)
        vm = PeopleViewModel(networkManager: networkManager)
    }
    
    override func tearDown() {
        networkManager = nil
        urlSession = nil
        vm = nil
    }

    func testFechPeopleSuccessCase() async{
        XCTAssertTrue(vm.people.count == 0)
        XCTAssertTrue(vm.page == 0)
        XCTAssertTrue(vm.totalPages == 1)
        XCTAssertNil(vm.state)
        
        await vm.fetchPeople()
        
        XCTAssertTrue(vm.people.count == 6)
        XCTAssertTrue(vm.page == 1)
        XCTAssertTrue(vm.totalPages == 2)
        XCTAssertTrue(vm.state == .idle)
        
        await vm.fetchPeople()
        
        XCTAssertTrue(vm.people.count == 12)
        XCTAssertTrue(vm.page == 2)
        XCTAssertTrue(vm.totalPages == 2)
        XCTAssertTrue(vm.state == .idle)
        
        await vm.fetchPeople()
        
        XCTAssertTrue(vm.people.count == 12)
        XCTAssertTrue(vm.page == 2)
        XCTAssertTrue(vm.totalPages == 2)
        XCTAssertTrue(vm.state == .idle)
    }
    
    func testResetCase() async {
        XCTAssertTrue(vm.people.count == 0)
        XCTAssertTrue(vm.page == 0)
        XCTAssertTrue(vm.totalPages == 1)
        XCTAssertNil(vm.state)
        
        await vm.fetchPeople()
        
        XCTAssertTrue(vm.people.count == 6)
        XCTAssertTrue(vm.page == 1)
        XCTAssertTrue(vm.totalPages == 2)
        XCTAssertTrue(vm.state == .idle)
        
        vm.reset()
        
        XCTAssertTrue(vm.people.count == 0)
        XCTAssertTrue(vm.page == 0)
        XCTAssertTrue(vm.totalPages == 1)
        XCTAssertNil(vm.state)
    }
    
    func testHasReachedEndCase() async {
        await vm.fetchPeople()
        
        XCTAssertFalse(vm.hasReachedEnd(of: vm.people.first!))
        XCTAssertTrue(vm.hasReachedEnd(of: vm.people.last!))
    }
}
