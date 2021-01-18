//
//  PersonDetailViewModel.swift
//  TMDbNetworkService
//
//  Created by Cem Kazım on 18.01.2021.
//

import Foundation

class PersonDetailViewModel {
    
    public var movieCastModel: MovieCastModel?
    
    init(movieCastModel: MovieCastModel) {
        self.movieCastModel = movieCastModel
    }
}
