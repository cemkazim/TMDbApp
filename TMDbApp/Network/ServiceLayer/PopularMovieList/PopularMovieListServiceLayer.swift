//
//  PopularMovieListServiceLayer.swift
//  TMDbApp
//
//  Created by Cem Kazım on 24.01.2021.
//

import Foundation
import RxSwift

class PopularMovieListServiceLayer {
    
    static let shared = PopularMovieListServiceLayer()
    private var disposeBag = DisposeBag()
    
    private init() {}
    
    func getMovieList(completionHandler: @escaping ([MovieResults]) -> Void, errorHandler: @escaping (Error) -> Void) {
        BaseNetworkLayer
            .shared
            .request(requestUrl: APIUrl.shared.getPopularMovieListUrl(),
                     requestMethod: .get)
            .subscribe(onNext: { (data: PopularMovies) in
            completionHandler(data.results)
        }, onError: { (error: Error) in
            errorHandler(error)
        }).disposed(by: disposeBag)
    }
}
