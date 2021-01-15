//
//  MovieListTests.swift
//  TMDbAppTests
//
//  Created by Cem Kazım on 16.01.2021.
//

@testable import TMDbApp
import XCTest

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
    
    func testing_movie_model() {
        let movieModel = MovieModel(title: "Monsters of Man", imageUrl: "/1f3qspv64L5FXrRy0MF8X92ieuw.jpg", releaseDate: "2020-11-19")
        movieListViewController?.movieListViewModel.movieModelList = [movieModel]
        XCTAssertNotNil(movieListViewController?.movieListViewModel.movieModelList)
    }
    
    func testing_movie_results() {
        movieListViewModel?.networkService.getMovieResult(completionHandler: { [weak self] (data) in
            guard let self = self else { return }
            self.movieResults = data.results
            XCTAssertNotNil(self.movieResults)
        })
    }
    
    func testing_set_movie_list() {
        let movieResultModel = MovieResultModel(id: 508442, title: "Soul", posterPath: "/hm58Jw4Lw8OIeECIq5qyPYhAeRJ.jpg", overview: "Joe Gardner is a middle school teacher with a love for jazz music. After a successful gig at the Half Note Club, he suddenly gets into an accident that separates his soul from his body and is transported to the You Seminar, a center in which souls develop and gain passions before being transported to a newborn child. Joe must enlist help from the other souls-in-training, like 22, a soul who has spent eons in the You Seminar, in order to get back to Earth.", releaseDate: "2020-12-25", voteAverage: 8.4, popularity: 2849.972)
        movieListViewModel?.setMovieList([movieResultModel])
        XCTAssertNotNil(movieListViewModel?.movieModelList)
    }
}
