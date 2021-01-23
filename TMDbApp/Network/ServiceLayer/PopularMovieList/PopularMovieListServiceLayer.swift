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
    
    func getMovieList(completionHandler: @escaping ([MovieResultModel]) -> ()) {
        BaseNetworkLayer
            .shared
            .request(requestUrl: APIParam.movieBaseUrl.rawValue + APIParam.movieResultUrl.rawValue)
            .subscribe(onNext: { (data: MovieList) in
                completionHandler(data.results)
            }, onError: { (error: Error) in
                print(error)
            }).disposed(by: disposeBag)
    }
}
