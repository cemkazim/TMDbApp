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
    var creditsUrl = ""
    private var disposeBag = DisposeBag()
    
    weak var delegate: MovieDetailViewModelDelegate?
    
    init(movieResultModel: MovieResultModel?) {
        self.movieResultModel = movieResultModel
        creditsUrl = "\(APIParam.movieBaseUrl.rawValue)\(movieResultModel?.id ?? 0)\(APIParam.movieCreditsUrl.rawValue)"
        getData()
    }
    
    func getData() {
        NetworkManager.shared.getData(requestUrl: creditsUrl).subscribe(onNext: { [weak self] (data: MovieCredits) in
            guard let self = self else { return }
            self.delegate?.getMovieCast(movieCast: data.cast)
        }, onError: { (error: Error) in
            print(error)
        }).disposed(by: disposeBag)
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
