//
//  MovieDetailTests.swift
//  TMDbAppTests
//
//  Created by Cem Kazım on 16.01.2021.
//

@testable import TMDbApp
import XCTest
import TMDbComponents

class MovieDetailTests: XCTestCase {
    
    var movieDetailViewController: MovieDetailViewController?
    var movieDetailViewModel: MovieDetailViewModel?
    
    override func setUp() {
        super.setUp()
        movieDetailViewController = MovieDetailViewController()
        movieDetailViewModel = MovieDetailViewModel(movieResultModel: nil)
    }
    
    func testing_get_data() {
        let movieResultModel = MovieResultModel(id: 508442, title: "Soul", posterPath: "/hm58Jw4Lw8OIeECIq5qyPYhAeRJ.jpg", overview: "Joe Gardner is a middle school teacher with a love for jazz music. After a successful gig at the Half Note Club, he suddenly gets into an accident that separates his soul from his body and is transported to the You Seminar, a center in which souls develop and gain passions before being transported to a newborn child. Joe must enlist help from the other souls-in-training, like 22, a soul who has spent eons in the You Seminar, in order to get back to Earth.", releaseDate: "2020-12-25", voteAverage: 8.4, popularity: 2849.972)
        movieDetailViewController?.getDataFrom(movieResultModel)
        XCTAssertNotNil(movieDetailViewController?.titleLabel.text)
        XCTAssertNotNil(movieDetailViewController?.coverImageView)
        XCTAssertNotNil(movieDetailViewController?.ratingLabel.text)
        XCTAssertNotNil(movieDetailViewController?.summaryLabel.text)
        XCTAssertNotNil(movieDetailViewController?.releaseDateLabel.text)
    }
    
    func testing_movie_cast_model() {
        let movieCastModel = MovieCastModel(name: "Gal Gadot", character: "Diana Prince / Wonder Woman", knownForDepartment: "Acting", profilePath: "/xu1l9WmNY1XYZyJ3M2gvGqCCDGS.jpg", gender: 1, popularity: 39.554)
        movieDetailViewModel?.movieCast = [movieCastModel]
        XCTAssertNotNil(movieDetailViewModel?.movieCast)
    }
}
