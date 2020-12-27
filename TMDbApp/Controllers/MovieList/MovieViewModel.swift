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
    
    func getMovieList(completionHandler: @escaping ([MovieResult]) -> ()) {
        AF.request(APIUrl.movieList, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil).response { [weak self] (response) in
            guard let movieListData = response.data, let strongSelf = self else { return }
            do {
                let movieListModel = try JSONDecoder().decode(MovieListModel.self, from: movieListData)
                let movieResults = movieListModel.results
                strongSelf.setImageUrl(movieResults)
                completionHandler(movieResults)
            } catch let error {
                print(error)
            }
        }
    }
    
    func setImageUrl(_ movieResults: [MovieResult]) {
        for path in movieResults {
            if let posterPath = path.posterPath {
                movieImageUrlList.append(APIUrl.baseMovieImageUrl + posterPath)
            }
        }
    }
    
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
    
    func getMovieCredits(movieId: Int, completionHandler: @escaping ([MovieGenre]) -> ()) {
        let parameters: Parameters = ["movie_genre": "123456"]
        let movieCreditsApiUrl = "https://api.themoviedb.org/3/movie/\(movieId)/credits?api_key=fc4147091caa304654154fb4dee3bf04&language=en-US"
        AF.request(movieCreditsApiUrl, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil, interceptor: nil).response { (response) in
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
