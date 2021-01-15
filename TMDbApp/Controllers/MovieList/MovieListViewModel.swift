//
//  MovieListViewModel.swift
//  TMDbApp
//
//  Created by Cem Kazım on 26.12.2020.
//

import Foundation
import Alamofire

protocol MovieListViewModelDelegate: class {
    func getMovieModelList(_ movieModelList: [MovieModel])
}

class MovieListViewModel {
    
    // MARK: - Properties -
    
    public var movieResults: [MovieResultModel] = []
    private var movieModel: MovieModel?
    public var movieModelList: [MovieModel] = []
    public var filteredMovieModelList: [MovieModel] = []
    public var networkService = NetworkService()
    
    public weak var delegate: MovieListViewModelDelegate?
    
    init() {
        getData()
    }
    
    private func getData() {
        networkService.getMovieResult(completionHandler: { [weak self] (data) in
            guard let self = self else { return }
            self.movieResults = data.results
            self.setMovieList()
        })
    }
    
    private func setMovieList() {
        for result in movieResults {
            if let imagePath = result.posterPath, let title = result.title, let releaseDate = result.releaseDate {
                movieModel = MovieModel(title: title, imageUrl: APIParams.baseMovieImageUrl + imagePath, releaseDate: releaseDate)
                if let model = movieModel {
                    movieModelList.append(model)
                }
            }
        }
        delegate?.getMovieModelList(movieModelList)
    }
}
