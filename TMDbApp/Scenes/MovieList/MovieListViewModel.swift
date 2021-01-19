//
//  MovieListViewModel.swift
//  TMDbApp
//
//  Created by Cem Kazım on 26.12.2020.
//

import Foundation
import RxSwift

protocol MovieListViewModelDelegate: class {
    func getMovieModelList(_ movieModelList: [MovieModel])
}

class MovieListViewModel {
    
    var movieResults: [MovieResultModel] = []
    var movieModel: MovieModel?
    var movieModelList: [MovieModel] = []
    var filteredMovieModelList: [MovieModel] = []
    private var disposeBag = DisposeBag()
    
    weak var delegate: MovieListViewModelDelegate?
    
    init() {
        getData()
    }
    
    func getData() {
        NetworkManager.shared.getMovieList().subscribe(onNext: { [weak self] data in
            guard let self = self else { return }
            self.movieResults = data.results
            self.setMovieList(data.results)
        }, onError: { error in
            print(error)
        }).disposed(by: disposeBag)
    }
    
    func setMovieList(_ results: [MovieResultModel]) {
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
