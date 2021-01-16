//
//  APIParam.swift
//  NetworkService
//
//  Created by Cem Kazım on 16.01.2021.
//

import Foundation


public class APIParam {
    
    public static let apiKey = "fc4147091caa304654154fb4dee3bf04"
    public static let keyToken = "?api_key="
    public static let movieBaseUrl = "https://api.themoviedb.org/3/movie/"
    public static let popularMovie = "popular"
    public static let credits = "/credits"
    public static let otherParam = "&language=en-US"
    public static let baseMovieImageUrl = "https://image.tmdb.org/t/p/original"
        
    public static let popularMovieUrl = movieBaseUrl + popularMovie + keyToken + apiKey + otherParam
    public static let creditsUrl = credits + keyToken + apiKey + otherParam
    public static let parameters = [MockParam.movieId.rawValue: MockParam.id.rawValue]
}
