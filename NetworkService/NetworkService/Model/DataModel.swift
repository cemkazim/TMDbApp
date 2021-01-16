//
//  DataModel.swift
//  NetworkService
//
//  Created by Cem Kazım on 16.01.2021.
//

import Foundation

// MARK: - Movie List Models -

public struct MovieList: Decodable {
    
    public let page: Int
    public let results: [MovieResultModel]
    
    enum CodingKeys: String, CodingKey {
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
    
    public var title: String?
    public var imageUrl: String?
    public var releaseDate: String?
    
    public init(title: String?, imageUrl: String?, releaseDate: String?) {
        self.title = title
        self.imageUrl = imageUrl
        self.releaseDate = releaseDate
    }
}

// MARK: - Movie Detail Models -

public struct MovieCollection: Decodable {
    
    public let id: Int?
    public let name: String?
    public let posterPath: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case posterPath = "poster_path"
    }
}

public struct MovieCredits: Decodable {
    
    public let id: Int?
    public let cast: [MovieCastModel]
    
    enum CodingKeys: String, CodingKey {
        case id
        case cast
    }
}

public class CastList {
    
    public var name: String?
    public var imagePath: String?
    
    public init(name: String?, imagePath: String?) {
        self.name = name
        self.imagePath = imagePath
    }
}

// MARK: - Person Detail Models -

public struct MovieCastModel: Decodable {
    
    public let name: String?
    public let character: String?
    public let knownForDepartment: String?
    public let profilePath: String?
    public let gender: Int?
    public let popularity: Double?
    
    enum CodingKeys: String, CodingKey {
        case name
        case character
        case gender
        case popularity
        case knownForDepartment = "known_for_department"
        case profilePath = "profile_path"
    }
}
