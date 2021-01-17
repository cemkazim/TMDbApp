//
//  MovieListTests.swift
//  TMDbAppTests
//
//  Created by Cem Kazım on 16.01.2021.
//

@testable import TMDbApp
import XCTest
import TMDbNetworkService
import TMDbComponents

class MovieListViewControllerTest: XCTestCase {
    
    var movieListViewController: MovieListViewController?
    var movieListViewModel: MovieListViewModel?
    var movieResults: [MovieResultModel] = []
    
    override func setUp() {
        super.setUp()
        movieListViewController = MovieListViewController()
        movieListViewModel = MovieListViewModel()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testingMovieModel() {
        let movieModel = MovieModel(title: "Monsters of Man", imageUrl: "/1f3qspv64L5FXrRy0MF8X92ieuw.jpg", releaseDate: "2020-11-19")
        movieListViewController?.movieListViewModel.movieModelList = [movieModel]
        XCTAssertNotNil(movieListViewController?.movieListViewModel.movieModelList)
    }
    
    func testingMovieResults() {
        let expect = expectation(description: "Get data")
        movieListViewModel?.networkManager.getMovieResult(completionHandler: { [weak self] (data) in
            guard let self = self else { return }
            self.movieResults = data.results
            XCTAssertNotNil(self.movieResults)
            expect.fulfill()
        })
        waitForExpectations(timeout: 10, handler: nil)
    }
}
