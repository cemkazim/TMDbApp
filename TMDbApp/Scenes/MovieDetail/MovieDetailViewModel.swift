//
//  MovieDetailViewModel.swift
//  TMDbApp
//
//  Created by Cem Kazım on 18.01.2021.
//

import Foundation
import RxSwift

protocol MovieDetailViewModelDelegate: class {
    func setMovieCast(movieCast: [MovieCastModel])
}

class MovieDetailViewModel {
    
    var movieResultModel: MovieResultModel?
    var movieCast = [MovieCastModel]()
    var castList = [CastList]()
    private var disposeBag = DisposeBag()
    
    weak var delegate: MovieDetailViewModelDelegate?
    
    init(movieResultModel: MovieResultModel?) {
        self.movieResultModel = movieResultModel
        getData()
    }
    
    func getData() {
        ServiceLayer.shared.getMovieCast(movieId: movieResultModel?.id ?? 0, completionHandler: { [weak self] (cast) in
            guard let self = self else { return }
            self.delegate?.setMovieCast(movieCast: cast)
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
