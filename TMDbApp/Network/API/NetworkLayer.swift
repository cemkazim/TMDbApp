//
//  NetworkLayer.swift
//  TMDbApp
//
//  Created by Cem Kazım on 16.01.2021.
//

import Alamofire
import RxSwift

class NetworkLayer {
    
    static let shared = NetworkLayer()
    
    private init() {}
    
    func request<T: Decodable>(requestUrl: String, requestParameters: Parameters? = nil) -> Observable<T> {
        return Observable.create { observer -> Disposable in
            AF.request(requestUrl, method: .get, parameters: requestParameters, encoding: URLEncoding.default).response { (response) in
                guard let remoteData = response.data else { return }
                do {
                    let localData = try JSONDecoder().decode(T.self, from: remoteData)
                    observer.onNext(localData)
                } catch let error {
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }
}