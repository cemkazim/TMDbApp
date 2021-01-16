//
//  MovieDetailViewModel.swift
//  TMDbApp
//
//  Created by Cem Kazım on 27.12.2020.
//

import UIKit
import TMDbNetworkService
import TMDbUtilities

protocol MovieDetailViewModelDelegate: class {
    func getMovieCast(movieCast: [MovieCastModel])
}

class MovieDetailViewModel {
    
    public var movieResultModel: MovieResultModel?
    public var movieCast = [MovieCastModel]()
    public var castList = [CastList]()
    public var networkManager = NetworkManager()
    
    public weak var delegate: MovieDetailViewModelDelegate?
    
    init(movieResultModel: MovieResultModel?) {
        self.movieResultModel = movieResultModel
        getData()
    }
    
    public func getData() {
        networkManager.getMovieCredits(movieId: movieResultModel?.id ?? 0, completionHandler: { [weak self] (data) in
            guard let self = self else { return }
            self.delegate?.getMovieCast(movieCast: data.cast)
        })
    }
    
    public func dateFormatter(_ stringDate: String) -> String {
        let getterFormatter = DateFormatter()
        getterFormatter.dateFormat = ConstantValue.onlyDateFormat
        let setterFormater = DateFormatter()
        setterFormater.dateFormat = ConstantValue.withMonthDateFormat
        let date = getterFormatter.date(from: stringDate)
        return setterFormater.string(from: date ?? Date())
    }
}
