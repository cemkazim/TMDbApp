//
//  NetworkManager.swift
//  NetworkService
//
//  Created by Cem Kazım on 16.01.2021.
//

import Foundation
import Alamofire
import RxSwift

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {
        // initialized...
    }
    
    func getData<T: Decodable>(requestUrl: String) -> Observable<T> {
        return Observable.create { observer -> Disposable in
            let dataProtocol = BaseDataProtocol<T>()
            dataProtocol.sendRequest(with: requestUrl, completionHandler: { (data: T) in
                observer.onNext(data)
            }, errorHandler: { (error) in
                observer.onError(error)
            })
            return Disposables.create()
        }
    }
}
