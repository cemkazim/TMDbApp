//
//  NetworkServiceTests.swift
//  TMDbAppTests
//
//  Created by Cem Kazım on 16.01.2021.
//

@testable import TMDbApp
import XCTest

class NetworkServiceTests: XCTestCase {

    var networkService: NetworkService?
    var credits: MovieCredits?
    var results: MovieList?
    
    override func setUp() {
        super.setUp()
        networkService = NetworkService()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testing_get_movie_result_method() {
        networkService?.getMovieResult(completionHandler: { [weak self] (results) in
            guard let self = self else { return }
            self.results = results
            XCTAssertNotNil(self.results)
        })
    }
    
    func testing_get_movie_credits_method() {
        networkService?.getMovieCredits(movieId: 733317, completionHandler: { [weak self] (credits) in
            guard let self = self else { return }
            self.credits = credits
            XCTAssertNotNil(self.credits)
        })
    }
}
