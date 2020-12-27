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
    
    init(movieId: Int?, movieName: String, movieImageUrl: URL?) {
        self.movieId = movieId
        self.movieName = movieName
        self.movieImageUrl = movieImageUrl
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
    
    enum CodingKeys: String, CodingKey {
        case name
        case character
        case knownForDepartment = "known_for_department"
    }
}