//
//  MovieListViewModel.swift
//  TMDbApp
//
//  Created by Cem Kazım on 26.12.2020.
//

import Foundation
import TMDbNetworkService
import TMDbUtilities
import TMDbComponents

protocol MovieListViewModelDelegate: class {
    func getMovieModelList(_ movieModelList: [MovieModel])
}

class MovieListViewModel {
    
    public var movieResults: [MovieResultModel] = []
    public var movieModel: MovieModel?
    public var movieModelList: [MovieModel] = []
    public var filteredMovieModelList: [MovieModel] = []
    public var networkManager = NetworkManager()
    
    public weak var delegate: MovieListViewModelDelegate?
    
    init() {
        getData()
    }
    
    public func getData() {
        networkManager.getMovieResult(completionHandler: { [weak self] (data) in
            guard let self = self else { return }
            self.movieResults = data.results
            self.setMovieList(data.results)
        })
    }
    
    public func setMovieList(_ results: [MovieResultModel]) {
        for movie in results {
            if let imagePath = movie.posterPath, let title = movie.title, let releaseDate = movie.releaseDate {
                movieModel = MovieModel(title: title, imageUrl: APIParam.baseMovieImageUrl + imagePath, releaseDate: releaseDate)
                if let model = movieModel {
                    movieModelList.append(model)
                }
            }
        }
        delegate?.getMovieModelList(movieModelList)
    }
}
