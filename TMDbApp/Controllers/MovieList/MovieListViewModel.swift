//
//  MovieListViewModel.swift
//  TMDbApp
//
//  Created by Cem Kazım on 26.12.2020.
//

import Foundation
import Alamofire

protocol MovieListViewModelDelegate: class {
    func getMovieResultList(movieResultList: [MovieResultListModel])
}

class MovieListViewModel {
    
    // MARK: - Properties -
    
    public var movieResults: [MovieResultModel] = []
    private var movieResultListModel: MovieResultListModel?
    public var movieResultList: [MovieResultListModel] = []
    public var filteredMovieResultList: [MovieResultListModel] = []
    
    public weak var delegate: MovieListViewModelDelegate?
    
    init() {
        getMovieResult()
    }
    
    func getMovieResult() {
        let movieListUrl = APIParams.movieBaseUrl + APIParams.popularMovieExtension + APIParams.keyToken + APIParams.apiKey + APIParams.otherParam
        AF.request(movieListUrl, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil).response { [weak self] (response) in
            guard let movieListData = response.data, let self = self else { return }
            do {
                let movieList = try JSONDecoder().decode(MovieListModel.self, from: movieListData)
                self.movieResults = movieList.results
                self.setMovieList()
            } catch let error {
                print(error)
            }
        }
    }
    
    private func setMovieList() {
        for result in movieResults {
            if let imagePath = result.posterPath, let title = result.title, let releaseDate = result.releaseDate {
                movieResultListModel = MovieResultListModel(title: title, imageUrl: APIParams.baseMovieImageUrl + imagePath, releaseDate: releaseDate)
                if let model = movieResultListModel {
                    movieResultList.append(model)
                }
            }
        }
        delegate?.getMovieResultList(movieResultList: movieResultList)
    }
}
