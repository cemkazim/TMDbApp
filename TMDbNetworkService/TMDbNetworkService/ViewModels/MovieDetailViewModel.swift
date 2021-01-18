//
//  MovieDetailViewModel.swift
//  TMDbNetworkService
//
//  Created by Cem Kazım on 18.01.2021.
//

import Foundation
import RxSwift
import TMDbUtilities

public protocol MovieDetailViewModelDelegate: class {
    func getMovieCast(movieCast: [MovieCastModel])
}

public class MovieDetailViewModel {
    
    public var movieResultModel: MovieResultModel?
    public var movieCast = [MovieCastModel]()
    public var castList = [CastList]()
    private var disposeBag = DisposeBag()
    
    public weak var delegate: MovieDetailViewModelDelegate?
    
    public init(movieResultModel: MovieResultModel?) {
        self.movieResultModel = movieResultModel
        getData()
    }
    
    public func getData() {
        NetworkManager.shared.getMovieCredits(movieId: movieResultModel?.id ?? 0).subscribe(onNext: { [weak self] (data) in
            guard let self = self else { return }
            self.delegate?.getMovieCast(movieCast: data.cast)
        }, onError: { (error) in
            print(error)
        }).disposed(by: disposeBag)
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
