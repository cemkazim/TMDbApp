//
//  MovieDetailModel.swift
//  TMDbApp
//
//  Created by Cem Kazım on 27.12.2020.
//

import Foundation

// MARK: - Movie Collection Model -

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

// MARK: - Movie Credits Model -

struct MovieCredits: Decodable {
    
    let id: Int?
    let cast: [MovieCast]
    
    enum CodingKeys: String, CodingKey {
        case id
        case cast
    }
}

// MARK: - Movie Cast Model -

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

class CastList {
    
    var name: String?
    var imagePath: String?
    
    init(name: String?, imagePath: String?) {
        self.name = name
        self.imagePath = imagePath
    }
}
