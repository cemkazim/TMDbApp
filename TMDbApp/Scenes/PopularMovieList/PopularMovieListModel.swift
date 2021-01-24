//
//  MovieListModel.swift
//  TMDbApp
//
//  Created by Cem Kazım on 18.01.2021.
//

import Foundation

struct PopularMovies: Decodable {
    
    let page: Int
    let results: [MovieResults]
    
    enum CodingKeys: String, CodingKey {
        case page
        case results
    }
}

struct MovieResults: Decodable {
    
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

public class MovieModel {
    
    var title: String?
    var imageUrl: String?
    var releaseDate: String?
    
    public init(title: String?, imageUrl: String?, releaseDate: String?) {
        self.title = title
        self.imageUrl = imageUrl
        self.releaseDate = releaseDate
    }
}
