//
//  NetworkManager.swift
//  NetworkService
//
//  Created by Cem Kazım on 16.01.2021.
//

import Foundation
import Alamofire
import TMDbUtilities
import TMDbComponents

public class NetworkManager {
    
    public init() {
        // networking...
    }
    
    // MARK: - Movie List Query -
    
    public func getMovieList(completionHandler: @escaping (MovieList) -> ()) {
        AF.request(APIParam.popularMovieUrl, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil).response { (response) in
            guard let movieListData = response.data else { return }
            do {
                let json = JSONDecoder()
                let movieList = try json.decode(MovieList.self, from: movieListData)
                completionHandler(movieList)
            } catch {
                fatalError("MovieList data could not be retrieved")
            }
        }
    }
    
    // MARK: - Movie Detail Query -
    
    public func getMovieCredits(movieId: Int, completionHandler: @escaping (MovieCredits) -> ()) {
        let creditsUrl = "\(APIParam.movieBaseUrl)\(movieId)\(APIParam.creditsUrl)"
        AF.request(creditsUrl, method: .get, parameters: APIParam.parameters, encoding: URLEncoding.default, headers: nil, interceptor: nil).response { (response) in
            guard let movieCastData = response.data else { return }
            do {
                let json = JSONDecoder()
                let movieCredits = try json.decode(MovieCredits.self, from: movieCastData)
                completionHandler(movieCredits)
            } catch {
                fatalError("MovieCredits data could not be retrieved")
            }
        }
    }
}
