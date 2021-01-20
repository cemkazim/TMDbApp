//
//  MovieDetailViewModel.swift
//  TMDbApp
//
//  Created by Cem Kazım on 18.01.2021.
//

import Foundation
import RxSwift

protocol MovieDetailViewModelDelegate: class {
    func getMovieCast(movieCast: [MovieCastModel])
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
        NetworkManager.shared.getMovieCredits(movieId: movieResultModel?.id ?? 0).subscribe(onNext: { [weak self] (data) in
            guard let self = self else { return }
            self.delegate?.getMovieCast(movieCast: data.cast)
        }, onError: { (error) in
            print(error)
        }).disposed(by: disposeBag)
    }
    
    func dateFormatter(_ stringDate: String) -> String {
        let getterFormatter = DateFormatter()
        getterFormatter.dateFormat = ConstantValue.onlyDateFormat
        let setterFormater = DateFormatter()
        setterFormater.dateFormat = ConstantValue.withMonthDateFormat
        let date = getterFormatter.date(from: stringDate)
        return setterFormater.string(from: date ?? Date())
    }
}
