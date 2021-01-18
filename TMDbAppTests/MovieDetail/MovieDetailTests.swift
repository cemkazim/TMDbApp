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
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testingMovieCredits() {
        movieDetailViewModel?.getData()
        XCTAssertNotNil(movieDetailViewModel?.delegate)
    }
}
