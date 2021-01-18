//
//  MovieDetailModel.swift
//  TMDbNetworkService
//
//  Created by Cem Kazım on 18.01.2021.
//

import Foundation

public struct MovieCollection: Decodable {
    
    public let id: Int?
    public let name: String?
    public let posterPath: String?
    
    public enum CodingKeys: String, CodingKey {
        case id
        case name
        case posterPath = "poster_path"
    }
}

public struct MovieCredits: Decodable {
    
    public let id: Int?
    public let cast: [MovieCastModel]
    
    public enum CodingKeys: String, CodingKey {
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
