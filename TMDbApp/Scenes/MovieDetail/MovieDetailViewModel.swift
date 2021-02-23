//
//  MovieDetailViewModel.swift
//  TMDbApp
//
//  Created by Cem Kazım on 18.01.2021.
//

import Foundation

protocol MovieDetailViewModelDelegate: class {
    func setMovieCast(_ personDetailList: [PersonDetailModel])
}

class MovieDetailViewModel {
    
    var movieResults: MovieResults?
    var personDetailList = [PersonDetailModel]()
    var castList = [CastModel]()
    
    weak var delegate: MovieDetailViewModelDelegate?
    
    init(movieResults: MovieResults?) {
        self.movieResults = movieResults
        getData()
    }
    
    func getData() {
        MovieDetailServiceLayer.shared.getMovieCast(movieId: movieResults?.id ?? 0, completionHandler: { [weak self] (cast) in
            guard let self = self else { return }
            self.delegate?.setMovieCast(cast)
        })
    }
    
    func dateFormatter(_ stringDate: String) -> String {
        let getterFormatter = DateFormatter()
        getterFormatter.dateFormat = DateFormats.onlyDateFormat
        let setterFormater = DateFormatter()
        setterFormater.dateFormat = DateFormats.withMonthDateFormat
        let date = getterFormatter.date(from: stringDate)
        return setterFormater.string(from: date ?? Date())
    }
}
