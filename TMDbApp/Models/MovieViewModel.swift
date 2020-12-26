//
//  MovieViewModel.swift
//  TMDbApp
//
//  Created by Cem Kazım on 26.12.2020.
//

import Foundation
import Alamofire

class MovieViewModel {
    
    var movieImageUrlList = [String]()
    
    func getMovieList(completionHandler: @escaping ([Result]) -> ()) {
        let movieListApiUrl = "https://api.themoviedb.org/3/movie/popular?api_key=fc4147091caa304654154fb4dee3bf04&language=en-US&page=1"
        AF.request(movieListApiUrl, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil).response { [weak self] (response) in
            guard let movieListData = response.data, let strongSelf = self else { return }
            do {
                let movieListModel = try JSONDecoder().decode(MovieModel.self, from: movieListData)
                let movieResults = movieListModel.results
                strongSelf.setImageUrl(movieResults)
                completionHandler(movieResults)
            } catch let error {
                print(error)
            }
        }
    }
    
    func setImageUrl(_ movieResults: [Result]) {
        let movieImageBaseUrl = "https://image.tmdb.org/t/p/original"
        for path in movieResults {
            if let posterPath = path.posterPath {
                movieImageUrlList.append(movieImageBaseUrl + posterPath)
            }
        }
    }
    
    func getMovieGenre(movieId: Int, completionHandler: @escaping ([MovieGenre]) -> ()) {
        let parameters: Parameters = ["movie_genre": "123"]
        let movieGenreApiUrl = "https://api.themoviedb.org/3/movie/\(movieId)/credits?api_key=fc4147091caa304654154fb4dee3bf04&language=en-US"
        AF.request(movieGenreApiUrl, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil, interceptor: nil).response { [weak self] (response) in
            guard let movieGenreData = response.data, let strongSelf = self else { return }
            do {
                let movieListModel = try JSONDecoder().decode(MovieModel.self, from: movieGenreData)
                let movieResults = movieListModel.results
            } catch let error {
                print(error)
            }
        }
    }
}
