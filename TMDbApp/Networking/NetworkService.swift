//
//  NetworkService.swift
//  TMDbApp
//
//  Created by Cem Kazım on 15.01.2021.
//

import Foundation
import Alamofire

public class NetworkService {
    
    var movieListUrl: String = "" {
        didSet {
            movieListUrl = APIParams.movieBaseUrl + APIParams.popularMovieExtension + APIParams.keyToken + APIParams.apiKey + APIParams.otherParam
        }
    }
    
    public var movieId: Int = 0
    
    var movieCastUrl: String = ""
    
    var parameters: Parameters = [String: Any]() {
        didSet {
            parameters = [MockParams.movieId.rawValue: MockParams.id.rawValue]
        }
    }
    
    // MARK: - Movie List -
    
    public func getMovieResult(completionHandler: @escaping (MovieList) -> ()) {
        AF.request(movieListUrl, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil).response { (response) in
            guard let movieListData = response.data else { return }
            do {
                let movieList = try JSONDecoder().decode(MovieList.self, from: movieListData)
                completionHandler(movieList)
            } catch let error {
                print(error)
            }
        }
    }
    
    // MARK: - Movie Detail -
    
    public func getMovieCredits(movieId: Int, completionHandler: @escaping (MovieCredits) -> ()) {
        self.movieId = movieId
        movieCastUrl = "\(APIParams.movieBaseUrl)\(movieId)\(APIParams.creditsExtension)\(APIParams.keyToken)\(APIParams.apiKey)\(APIParams.otherParam)"
        AF.request(movieCastUrl, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil, interceptor: nil).response { (response) in
            guard let movieCastData = response.data else { return }
            do {
                let movieCredits = try JSONDecoder().decode(MovieCredits.self, from: movieCastData)
                completionHandler(movieCredits)
            } catch let error {
                print(error)
            }
        }
    }
}
