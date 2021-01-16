//
//  NetworkManager.swift
//  NetworkService
//
//  Created by Cem Kazım on 16.01.2021.
//

import Foundation
import Alamofire
import Utilities

public class NetworkManager {
    
    public init() {
        // networking...
    }
    
    // MARK: - Movie List Query -
    
    public func getMovieResult(completionHandler: @escaping (MovieList) -> ()) {
        AF.request(APIParam.popularMovieUrl, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil).response { (response) in
            guard let movieListData = response.data else { return }
            do {
                let movieList = try JSONDecoder().decode(MovieList.self, from: movieListData)
                completionHandler(movieList)
            } catch let error {
                print(error)
            }
        }
    }
    
    // MARK: - Movie Detail Query -
    
    public func getMovieCredits(movieId: Int, completionHandler: @escaping (MovieCredits) -> ()) {
        let creditsUrl = "\(APIParam.movieBaseUrl)\(movieId)\(APIParam.creditsUrl)"
        AF.request(creditsUrl, method: .get, parameters: APIParam.parameters, encoding: URLEncoding.default, headers: nil, interceptor: nil).response { (response) in
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
