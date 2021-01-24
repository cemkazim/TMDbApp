//
//  PopularMovieListViewModel.swift
//  TMDbApp
//
//  Created by Cem Kazım on 26.12.2020.
//

import Foundation

protocol PopularMovieListViewModelDelegate: class {
    func setMovieList(_ movieList: [MovieModel])
}

class PopularMovieListViewModel {
    
    // MARK: - Properties -
    
    var movieResults: [MovieResults] = []
    var movieModel: MovieModel?
    var movieList: [MovieModel] = []
    var filteredMovieList: [MovieModel] = []
    weak var delegate: PopularMovieListViewModelDelegate?
    
    // MARK: - Initialize -
    
    init() {
        getData()
    }
    
    // MARK: - Methods -
    
    func getData() {
        PopularMovieListServiceLayer.shared.getMovieList(completionHandler: { [weak self] (results) in
            guard let self = self else { return }
            self.movieResults = results
            self.setMovieList(results)
        })
    }
    
    func setMovieList(_ results: [MovieResults]) {
        movieResults = results
        for movie in results {
            if let imagePath = movie.posterPath, let title = movie.title, let releaseDate = movie.releaseDate {
                movieModel = MovieModel(title: title, imageUrl: APIParam.movieImageUrl.rawValue + imagePath, releaseDate: releaseDate)
                if let model = movieModel {
                    movieList.append(model)
                }
            }
        }
        delegate?.setMovieList(movieList)
    }
}
