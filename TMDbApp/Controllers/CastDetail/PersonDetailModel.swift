//
//  CastDetailModel.swift
//  TMDbApp
//
//  Created by Cem Kazım on 27.12.2020.
//

import Foundation

struct PersonDetailModel: Decodable {
    
    var personName: String?
    var personCharacter: String?
    var personKnownForDepartment: String?
    var personProfilePath: URL?
    var personGender: Int?
    var personPopularity: Double?
    
    init(personName: String?, personCharacter: String?, personKnownForDepartment: String?, personProfilePath: URL?, personGender: Int?, personPopularity: Double?) {
        self.personName = personName
        self.personCharacter = personCharacter
        self.personKnownForDepartment = personKnownForDepartment
        self.personProfilePath = personProfilePath
        self.personGender = personGender
        self.personPopularity = personPopularity
    }
}
