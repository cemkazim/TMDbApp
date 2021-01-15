//
//  MovieDetailViewModel.swift
//  TMDbApp
//
//  Created by Cem Kazım on 27.12.2020.
//

import UIKit
import Alamofire

protocol MovieDetailViewModelDelegate: class {
    func getMovieCast(movieCast: [MovieCastModel])
}

class MovieDetailViewModel {
    
    public var movieResultModel: MovieResultModel?
    public var movieCast = [MovieCastModel]()
    public var castList = [CastList]()
    
    public weak var delegate: MovieDetailViewModelDelegate?
    
    init(movieResultModel: MovieResultModel?) {
        self.movieResultModel = movieResultModel
        getMovieCredits()
    }
    
    private func getMovieCredits() {
        let parameters: Parameters = [CreditsParams.movieId.rawValue: CreditsParams.id.rawValue]
        let movieCastUrl = "\(APIParams.movieBaseUrl)\(movieResultModel?.id ?? 0)\(APIParams.creditsExtension)\(APIParams.keyToken)\(APIParams.apiKey)\(APIParams.otherParam)"
        AF.request(movieCastUrl, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil, interceptor: nil).response { (response) in
            guard let movieCastData = response.data else { return }
            do {
                let model = try JSONDecoder().decode(MovieCredits.self, from: movieCastData)
                self.delegate?.getMovieCast(movieCast: model.cast)
            } catch let error {
                print(error)
            }
        }
    }
    
    func dateFormatter(_ stringDate: String) -> String {
        let getterFormatter = DateFormatter()
        getterFormatter.dateFormat = ConstantValue.onlyDateFormat
        let setterFormater = DateFormatter()
        setterFormater.dateFormat = ConstantValue.withMonthDateFormat
        let date = getterFormatter.date(from: stringDate)
        return setterFormater.string(from: date ?? Date())
    }
}

enum CreditsParams: String {
    
    case movieId = "movie_id"
    case id = "123456"
}
