//
//  BaseDataProtocol.swift
//  TMDbApp
//
//  Created by Cem Kazım on 20.01.2021.
//

import Foundation
import Alamofire
import RxSwift

class BaseDataProtocol<T> {
    
    private init() {
        // initialized...
    }
    
    func sendRequest<T: Decodable>(with requestUrl: String, completionHandler: @escaping (T) -> (), errorHandler: @escaping (Error) -> ()) {
        AF.request(requestUrl, method: .get, parameters: [MockParam.movieId.rawValue: MockParam.id.rawValue], encoding: URLEncoding.default).response { (response) in
            guard let remoteData = response.data else { return }
            do {
                let localData = try JSONDecoder().decode(T.self, from: remoteData)
                completionHandler(localData)
            } catch let error {
                print(error)
            }
        }
    }
}
