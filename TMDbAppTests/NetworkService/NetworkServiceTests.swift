//
//  NetworkServiceTests.swift
//  TMDbAppTests
//
//  Created by Cem Kazım on 16.01.2021.
//

@testable import TMDbApp
import XCTest
import TMDbNetworkService
import TMDbComponents

class NetworkServiceTests: XCTestCase {

    var networkManager: NetworkManager?
    
    override func setUp() {
        super.setUp()
        networkManager = NetworkManager()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testingGetMovieList() {
        let expect = expectation(description: "Get Movie List")
        networkManager?.getMovieList(completionHandler: { (result) in
            XCTAssertNotNil(result)
            expect.fulfill()
        })
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testingGetMovieCredits() {
        let expect = expectation(description: "Get Movie Credits")
        networkManager?.getMovieCredits(movieId: 733317, completionHandler: { (credits) in
            XCTAssertNotNil(credits)
            expect.fulfill()
        })
        waitForExpectations(timeout: 10, handler: nil)
    }
}
