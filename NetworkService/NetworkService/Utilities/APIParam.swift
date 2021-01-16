//
//  APIParam.swift
//  NetworkService
//
//  Created by Cem Kazım on 16.01.2021.
//

import Foundation


class APIParam {
    
    static let apiKey = "fc4147091caa304654154fb4dee3bf04"
    static let keyToken = "?api_key="
    static let movieBaseUrl = "https://api.themoviedb.org/3/movie/"
    static let popularMovie = "popular"
    static let credits = "/credits"
    static let otherParam = "&language=en-US"
    static let baseMovieImageUrl = "https://image.tmdb.org/t/p/original"
        
    static let popularMovieUrl = movieBaseUrl + popularMovie + keyToken + apiKey + otherParam
    static let creditsUrl = credits + keyToken + apiKey + otherParam
    static let parameters = [MockParam.movieId.rawValue: MockParam.id.rawValue]
}
