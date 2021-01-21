//
//  NetworkManager.swift
//  NetworkService
//
//  Created by Cem Kazım on 16.01.2021.
//

import Foundation
import Alamofire
import RxSwift

class NetworkManager: BaseDataProtocol<MovieList> {
    
    static let shared = NetworkManager()
    private var data: MovieList?
    
    private init() {
        super.init(data: data)
    }
    
    // MARK: - Movie List Query -
    
    func getMovieList() -> Observable<MovieList> {
        return Observable.create { observer -> Disposable in
            AF.request(APIParam.movieBaseUrl.rawValue + APIParam.movieResultUrl.rawValue, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil).response { (response) in
                guard let movieListData = response.data else { return }
                do {
                    let movieList = try JSONDecoder().decode(MovieList.self, from: movieListData)
                    observer.onNext(movieList)
                } catch {
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }
    
    // MARK: - Movie Detail Query -
    
    func getMovieCredits(movieId: Int) -> Observable<MovieCredits> {
        return Observable.create { observer -> Disposable in
            let creditsUrl = "\(APIParam.movieBaseUrl.rawValue)\(movieId)\(APIParam.movieCreditsUrl.rawValue)"
            AF.request(creditsUrl, method: .get, parameters: [MockParam.movieId.rawValue: MockParam.id.rawValue], encoding: URLEncoding.default, headers: nil, interceptor: nil).response { (response) in
                guard let movieCastData = response.data else { return }
                do {
                    let movieCredits = try JSONDecoder().decode(MovieCredits.self, from: movieCastData)
                    observer.onNext(movieCredits)
                } catch {
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }
}
