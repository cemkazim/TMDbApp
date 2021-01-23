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
    
    func getMovieCast(movieId: Int, completionHandler: @escaping ([MovieCastModel]) -> ()) {
        let requestUrl = "\(APIParam.movieBaseUrl.rawValue)\(movieId)\(APIParam.movieCreditsUrl.rawValue)"
        BaseNetworkLayer
            .shared
            .request(requestUrl: requestUrl,
                     requestParameters: [MockParam.movieId.rawValue: MockParam.id.rawValue])
            .subscribe(onNext: { (data: MovieCredits) in
                completionHandler(data.cast)
            }, onError: { (error: Error) in
                print(error)
            }).disposed(by: disposeBag)
    }
}
