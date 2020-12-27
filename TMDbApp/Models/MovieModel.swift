//
//  MovieModel.swift
//  TMDbApp
//
//  Created by Cem Kazım on 26.12.2020.
//

import Foundation

struct MovieModel: Decodable {
    
    let page: Int
    let results: [Result]
    
    enum CodingKeys: String, CodingKey {
        case page
        case results
    }
}

struct Result: Decodable {
    
    let id: Int?
    let title: String?
    let posterPath: String?
    let overview: String?
    let releaseDate: String?
    let voteAverage: Double?
    let popularity: Double?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
    }
}

struct MovieDetail: Decodable {
    
    let belongsToCollection: MovieCollection?
    let genres: [MovieGenre]
    
    enum CodingKeys: String, CodingKey {
        case belongsToCollection = "belongs_to_collection"
        case genres
    }
}

struct MovieGenre: Decodable {
    
    let id: Int?
    let name: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
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
