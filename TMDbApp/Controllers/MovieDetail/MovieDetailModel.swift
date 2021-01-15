//
//  MovieDetailModel.swift
//  TMDbApp
//
//  Created by Cem Kazım on 27.12.2020.
//

import Foundation

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
