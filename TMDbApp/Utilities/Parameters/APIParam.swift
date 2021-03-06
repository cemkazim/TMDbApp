//
//  APIParam.swift
//  TMDbUtilities
//
//  Created by Cem Kazım on 16.01.2021.
//

import Foundation

enum APIParam: String {
    case movieBaseUrl = "https://api.themoviedb.org/3/movie/"
    case movieResultUrl = "popular?api_key=fc4147091caa304654154fb4dee3bf04&language=en-US"
    case movieCreditsUrl = "/credits?api_key=fc4147091caa304654154fb4dee3bf04&language=en-US"
    case movieImageUrl = "https://image.tmdb.org/t/p/original"
}

class APIUrl {
    
    static let shared = APIUrl()
    
    private init() {}
    
    func getPopularMovieListUrl() -> String {
        return APIParam.movieBaseUrl.rawValue + APIParam.movieResultUrl.rawValue
    }
    
    func getMovieDetailUrl(with movieId: Int) -> String {
        return "\(APIParam.movieBaseUrl.rawValue)\(movieId)\(APIParam.movieCreditsUrl.rawValue)"
    }
}
