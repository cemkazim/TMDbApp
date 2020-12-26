//
//  MovieDetailViewModel.swift
//  TMDbApp
//
//  Created by Cem Kazım on 27.12.2020.
//

import UIKit
import Alamofire

class MovieDetailViewModel {
    
    func getMovieGenre(movieId: Int, completionHandler: @escaping ([MovieGenre]) -> ()) {
        let parameters: Parameters = ["movie_genre": "123456"]
        let movieGenreApiUrl = "https://api.themoviedb.org/3/movie/\(movieId)?api_key=fc4147091caa304654154fb4dee3bf04&language=en-US"
        AF.request(movieGenreApiUrl, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil, interceptor: nil).response { (response) in
            guard let movieGenreData = response.data else { return }
            do {
                let movieGenreModel = try JSONDecoder().decode(MovieDetail.self, from: movieGenreData)
                let movieGenreList = movieGenreModel.genres
                completionHandler(movieGenreList)
            } catch let error {
                print(error)
            }
        }
    }
}
