//
//  MovieDetailServiceLayer.swift
//  TMDbApp
//
//  Created by Cem Kazım on 24.01.2021.
//

import Foundation
import RxSwift

class MovieDetailServiceLayer {
    
    static let shared = MovieDetailServiceLayer()
    private var disposeBag = DisposeBag()
    
    private init() {}
    
    func getMovieCast(movieId: Int, completionHandler: @escaping ([PersonDetailModel]) -> Void, errorHandler: @escaping (Error) -> Void) {
        BaseNetworkLayer
            .shared
            .request(requestUrl: APIUrl.shared.getMovieDetailUrl(with: movieId),
                     requestMethod: .get,
                     requestParameters: [MockParam.movieId.rawValue: MockParam.id.rawValue])
            .subscribe(onNext: { (data: MovieCredits) in
                completionHandler(data.cast)
            }, onError: { (error: Error) in
                errorHandler(error)
            }).disposed(by: disposeBag)
    }
}
