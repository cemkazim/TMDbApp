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
    
    private var data: T?
    
    init(data: T?) {
        self.data = data
    }
}
