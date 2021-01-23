//
//  PopularMovieListViewModel.swift
//  TMDbApp
//
//  Created by Cem Kazım on 26.12.2020.
//

import Foundation

protocol PopularMovieListViewModelDelegate: class {
    func setMovieModelList(_ movieModelList: [MovieModel])
}

class PopularMovieListViewModel {
    
    var movieResults: [MovieResultModel] = []
    var movieModel: MovieModel?
    var movieModelList: [MovieModel] = []
    var filteredMovieModelList: [MovieModel] = []
    
    weak var delegate: PopularMovieListViewModelDelegate?
    
    init() {
        getData()
    }
    
    func getData() {
        PopularMovieListServiceLayer.shared.getMovieList(completionHandler: { [weak self] (results) in
            guard let self = self else { return }
            self.movieResults = results
            self.setMovieList(results)
        })
    }
    
    func setMovieList(_ results: [MovieResultModel]) {
        movieResults = results
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
