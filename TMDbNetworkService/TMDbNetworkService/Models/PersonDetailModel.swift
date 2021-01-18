//
//  PersonDetailModel.swift
//  TMDbNetworkService
//
//  Created by Cem Kazım on 18.01.2021.
//

import Foundation

public struct MovieCastModel: Decodable {
    
    public let name: String?
    public let character: String?
    public let knownForDepartment: String?
    public let profilePath: String?
    public let gender: Int?
    public let popularity: Double?
    
    public enum CodingKeys: String, CodingKey {
        case name
        case character
        case gender
        case popularity
        case knownForDepartment = "known_for_department"
        case profilePath = "profile_path"
    }
}
