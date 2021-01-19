//
//  MovieDetailModel.swift
//  TMDbApp
//
//  Created by Cem Kazım on 18.01.2021.
//

import Foundation

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
    let cast: [MovieCastModel]
    
    enum CodingKeys: String, CodingKey {
        case id
        case cast
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
