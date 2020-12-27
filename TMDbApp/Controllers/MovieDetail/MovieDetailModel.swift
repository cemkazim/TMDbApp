//
//  MovieDetailModel.swift
//  TMDbApp
//
//  Created by Cem Kazım on 27.12.2020.
//

import Foundation

class MovieDetailModel {
    
    var movieId: Int?
    var movieName: String?
    var movieImageUrl: URL?
    var movieReleaseDate: String?
    var movieVoteAverage: Double?
    var overview: String?
    
    init(movieId: Int?, movieName: String?, movieImageUrl: URL?, movieReleaseDate: String?, movieVoteAverage: Double?, overview: String?) {
        self.movieId = movieId
        self.movieName = movieName
        self.movieImageUrl = movieImageUrl
        self.movieReleaseDate = movieReleaseDate
        self.movieVoteAverage = movieVoteAverage
        self.overview = overview
    }
}

struct MovieCollection: Decodable {
    
    let id: Int?
    let name: String?
    let posterPath: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case posterPath = "poster_path"
    }
}

struct MovieCredits: Decodable {
    
    let id: Int?
    let cast: [MovieCast]
    
    enum CodingKeys: String, CodingKey {
        case id
        case cast
    }
}

struct MovieCast: Decodable {
    
    let name: String?
    let character: String?
    let knownForDepartment: String?
    let profilePath: String?
    let gender: Int?
    let popularity: Double?
    
    enum CodingKeys: String, CodingKey {
        case name
        case character
        case gender
        case popularity
        case knownForDepartment = "known_for_department"
        case profilePath = "profile_path"
    }
}
