//
//  PersonDetailViewModel.swift
//  TMDbNetworkService
//
//  Created by Cem Kazım on 18.01.2021.
//

import Foundation

public class PersonDetailViewModel {
    
    public var movieCastModel: MovieCastModel?
    
    public init(movieCastModel: MovieCastModel) {
        self.movieCastModel = movieCastModel
    }
}
