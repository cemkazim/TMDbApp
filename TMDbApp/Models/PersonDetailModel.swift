//
//  PersonDetailModel.swift
//  TMDbApp
//
//  Created by Cem Kazım on 18.01.2021.
//

import Foundation

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
