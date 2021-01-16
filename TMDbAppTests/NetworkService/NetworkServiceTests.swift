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
    var credits: MovieCredits?
    var results: MovieList?
    
    override func setUp() {
        super.setUp()
        networkManager = NetworkManager()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testing_get_movie_result_method() {
        networkManager?.getMovieResult(completionHandler: { [weak self] (results) in
            guard let self = self else { return }
            self.results = results
            XCTAssertNotNil(self.results)
        })
    }
    
    func testing_get_movie_credits_method() {
        networkManager?.getMovieCredits(movieId: 733317, completionHandler: { [weak self] (credits) in
            guard let self = self else { return }
            self.credits = credits
            XCTAssertNotNil(self.credits)
        })
    }
}
