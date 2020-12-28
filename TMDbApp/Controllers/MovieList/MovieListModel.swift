//
//  MovieListModel.swift
//  TMDbApp
//
//  Created by Cem Kazım on 26.12.2020.
//

import Foundation

// MARK: - Movie List Model -

struct MovieListModel: Decodable {
    
    let page: Int
    let results: [MovieResult]
    
    enum CodingKeys: String, CodingKey {
        case page
        case results
    }
}

// MARK: - Movie Result Model -

struct MovieResult: Decodable {
    
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

// MARK: - Movie Detail Model -

struct MovieDetail: Decodable {
    
    let belongsToCollection: MovieCollection?
    let genres: [MovieGenre]
    
    enum CodingKeys: String, CodingKey {
        case belongsToCollection = "belongs_to_collection"
        case genres
    }
}

// MARK: - Movie Genre Model -

struct MovieGenre: Decodable {
    
    let id: Int?
    let name: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
}
