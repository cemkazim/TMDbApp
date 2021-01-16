//
//  DataModel.swift
//  NetworkService
//
//  Created by Cem Kazım on 16.01.2021.
//

import Foundation

// MARK: - Movie List Models -

public struct MovieList: Decodable {
    
    let page: Int
    let results: [MovieResultModel]
    
    enum CodingKeys: String, CodingKey {
        case page
        case results
    }
}

public struct MovieResultModel: Decodable {
    
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
    
    init(title: String?, imageUrl: String?, releaseDate: String?) {
        self.title = title
        self.imageUrl = imageUrl
        self.releaseDate = releaseDate
    }
}

// MARK: - Movie Detail Models -

public struct MovieCollection: Decodable {
    
    let id: Int?
    let name: String?
    let posterPath: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case posterPath = "poster_path"
    }
}

public struct MovieCredits: Decodable {
    
    let id: Int?
    let cast: [MovieCastModel]
    
    enum CodingKeys: String, CodingKey {
        case id
        case cast
    }
}

public class CastList {
    
    var name: String?
    var imagePath: String?
    
    init(name: String?, imagePath: String?) {
        self.name = name
        self.imagePath = imagePath
    }
}

// MARK: - Person Detail Models -

struct MovieCastModel: Decodable {
    
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
