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
    let results: [MovieResultModel]
    
    enum CodingKeys: String, CodingKey {
        case page
        case results
    }
}

// MARK: - Movie Result Model -

struct MovieResultModel: Decodable {
    
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

// MARK: - Movie Result List Model -

class MovieResultListModel {
    
    var title: String?
    var imageUrl: String?
    var releaseDate: String?
    
    init(title: String?, imageUrl: String?, releaseDate: String?) {
        self.title = title
        self.imageUrl = imageUrl
        self.releaseDate = releaseDate
    }
}
