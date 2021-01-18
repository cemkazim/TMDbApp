//
//  MovieListModel.swift
//  TMDbNetworkService
//
//  Created by Cem Kazım on 18.01.2021.
//

import Foundation

public struct MovieList: Decodable {
    
    public let page: Int
    public let results: [MovieResultModel]
    
    public enum CodingKeys: String, CodingKey {
        case page
        case results
    }
}

public struct MovieResultModel: Decodable {
    
    public let id: Int?
    public let title: String?
    public let posterPath: String?
    public let overview: String?
    public let releaseDate: String?
    public let voteAverage: Double?
    public let popularity: Double?
    
    public enum CodingKeys: String, CodingKey {
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
    
    public var title: String?
    public var imageUrl: String?
    public var releaseDate: String?
    
    public init(title: String?, imageUrl: String?, releaseDate: String?) {
        self.title = title
        self.imageUrl = imageUrl
        self.releaseDate = releaseDate
    }
}
