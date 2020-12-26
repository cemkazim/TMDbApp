//
//  MovieViewModel.swift
//  TMDbApp
//
//  Created by Cem Kazım on 26.12.2020.
//

import Foundation
import Alamofire
import AlamofireImage

class MovieViewModel {
    
    var movieListApiUrl = "https://api.themoviedb.org/3/movie/popular?api_key=fc4147091caa304654154fb4dee3bf04&language=en-US&page=1"
    var movieImageBaseUrl = "https://image.tmdb.org/t/p/original"
    var movieImageUrlList = [String]()
    var movieImageList = [UIImage]()
    
    func getMovieList(completionHandler: @escaping ([Result]) -> ()) {
        AF.request(movieListApiUrl, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil).response { [weak self] (response) in
            guard let movieData = response.data, let strongSelf = self else { return }
            do {
                let movieListModel = try JSONDecoder().decode(MovieModel.self, from: movieData)
                let movieResults = movieListModel.results
                strongSelf.setImageUrl(movieResults)
                strongSelf.getImage()
                completionHandler(movieResults)
            } catch let error {
                print(error)
            }
        }
    }
    
    func setImageUrl(_ movieResults: [Result]) {
        for path in movieResults {
            if let posterPath = path.posterPath {
                movieImageUrlList.append(movieImageBaseUrl + posterPath)
            }
        }
    }
    
    func getImage() {
        let downloader = ImageDownloader()
        for imageUrl in movieImageUrlList {
            if let url = URL(string: imageUrl) {
                let urlRequest = URLRequest(url: url)
                downloader.download(urlRequest, completion: { [weak self] (response) in
                    guard let strongSelf = self else { return }
                    if case .success(let image) = response.result {
                        strongSelf.movieImageList.append(image)
                    }
                })
            }
        }
    }
}
