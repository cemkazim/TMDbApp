//
//  MovieListViewModel.swift
//  TMDbApp
//
//  Created by Cem Kazım on 26.12.2020.
//

import Foundation

protocol MovieListViewModelDelegate: class {
    func setMovieModelList(_ movieModelList: [MovieModel])
}

class MovieListViewModel {
    
    var movieResults: [MovieResultModel] = []
    var movieModel: MovieModel?
    var movieModelList: [MovieModel] = []
    var filteredMovieModelList: [MovieModel] = []
    
    weak var delegate: MovieListViewModelDelegate?
    
    init() {
        getData()
    }
    
    func getData() {
        ServiceLayer.shared.getMovieList(completionHandler: { [weak self] (results) in
            guard let self = self else { return }
            self.movieResults = results
            self.setMovieList(results)
        })
    }
    
    func setMovieList(_ results: [MovieResultModel]) {
        for movie in results {
            if let imagePath = movie.posterPath, let title = movie.title, let releaseDate = movie.releaseDate {
                movieModel = MovieModel(title: title, imageUrl: APIParam.movieImageUrl.rawValue + imagePath, releaseDate: releaseDate)
                if let model = movieModel {
                    movieModelList.append(model)
                }
            }
        }
        delegate?.setMovieModelList(movieModelList)
    }
}
