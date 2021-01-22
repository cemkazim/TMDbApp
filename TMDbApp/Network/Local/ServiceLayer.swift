//
//  ServiceLayer.swift
//  TMDbApp
//
//  Created by Cem Kazım on 22.01.2021.
//

import Foundation
import RxSwift

class ServiceLayer {
    
    static let shared = ServiceLayer()
    private var disposeBag = DisposeBag()
    
    private init() {}
    
    func getMovieList(completionHandler: @escaping ([MovieResultModel]) -> ()) {
        NetworkLayer
            .shared
            .request(requestUrl: APIParam.movieBaseUrl.rawValue + APIParam.movieResultUrl.rawValue)
            .subscribe(onNext: { (data: MovieList) in
                completionHandler(data.results)
            }, onError: { (error: Error) in
                print(error)
            }).disposed(by: disposeBag)
    }
    
    func getMovieCast(movieId: Int, completionHandler: @escaping ([MovieCastModel]) -> ()) {
        let requestUrl = "\(APIParam.movieBaseUrl.rawValue)\(movieId)\(APIParam.movieCreditsUrl.rawValue)"
        NetworkLayer
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
