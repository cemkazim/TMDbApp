//
//  PersonDetailViewModel.swift
//  TMDbApp
//
//  Created by Cem Kazım on 15.01.2021.
//

import Foundation
import NetworkService

class PersonDetailViewModel {
    
    public var movieCastModel: MovieCastModel?
    
    init(movieCastModel: MovieCastModel) {
        self.movieCastModel = movieCastModel
    }
}
