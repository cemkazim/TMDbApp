//
//  MovieDetailTests.swift
//  TMDbAppTests
//
//  Created by Cem Kazım on 16.01.2021.
//

@testable import TMDbApp
import XCTest
import TMDbComponents
import TMDbNetworkService

class MovieDetailTests: XCTestCase {
    
    var movieDetailViewModel: MovieDetailViewModel?
    
    override func setUp() {
        super.setUp()
        movieDetailViewModel = MovieDetailViewModel(movieResultModel: nil)
    }
    
    func testingGetData() {
        let expect = expectation(description: "Get data")
        movieDetailViewModel?.networkManager.getMovieCredits(movieId: 508442, completionHandler: { [weak self] (response) in
            guard let self = self else { return }
            self.movieDetailViewModel?.movieCast = response.cast
            XCTAssertNotNil(self.movieDetailViewModel?.movieCast)
            expect.fulfill()
        })
        waitForExpectations(timeout: 10, handler: nil)
    }
}
