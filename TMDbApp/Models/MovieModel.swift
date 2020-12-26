//
//  MovieModel.swift
//  TMDbApp
//
//  Created by Cem Kazım on 26.12.2020.
//

import Foundation

// MARK: - Popular Movie List -

struct MovieModel: Decodable {
    
    let page: Int
    let results: [Result]
    
    enum CodingKeys: String, CodingKey {
        case page
        case results
    }
}

struct Result: Decodable {
    
    let title: String?
    let posterPath: String?
    let overview: String?
    let releaseDate: String?
    let voteAverage: Double?
    let popularity: Double?
    
    enum CodingKeys: String, CodingKey {
        case title
        case overview
        case popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
    }
}
