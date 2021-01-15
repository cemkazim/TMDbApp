//
//  NetworkService.swift
//  TMDbApp
//
//  Created by Cem Kazım on 15.01.2021.
//

import Foundation
import Alamofire

public class NetworkService {
    
    var parameters = [MockParams.movieId.rawValue: MockParams.id.rawValue]
    var apiUrl = APIUrl()
    
    // MARK: - Movie List -
    
    public func getMovieResult(completionHandler: @escaping (MovieList) -> ()) {
        AF.request(apiUrl.popularMovieUrl, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil).response { (response) in
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
        let creditsUrl = "\(APIParams.movieBaseUrl)\(movieId)\(apiUrl.creditsUrl)"
        AF.request(creditsUrl, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil, interceptor: nil).response { (response) in
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
