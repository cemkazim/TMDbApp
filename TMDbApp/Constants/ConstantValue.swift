//
//  ConstantValue.swift
//  TMDbApp
//
//  Created by Cem Kazım on 26.12.2020.
//

import Foundation
import UIKit

class ConstantValue {
    
    static let placeholderImage = "placeholder"
    static let initCoderText = "init(coder:) has not been implemented"
    static let movieListTableViewCellId = "MovieListTableViewCell"
    static let searchText = "Search"
    static let cancelButtonText = "Cancel"
    static let cancelButtonTextId = "cancelButtonText"
    static let movieDetailCollectionViewCellId = "MovieDetailCollectionViewCell"
    static let placeholderText = "'Learn and change future' - Cem Kazim"
    static let colorsKeyPath = "colors"
    static let colorChangeKey = "colorChange"
    static let nameText = "Name: "
    static let characterText = "Character: "
    static let voteAverageText = "Vote Average: "
    static let voteAverageDecimalText = "/10"
    static let releaseDateText = "Release Date: "
    static let knownForDepartmentText = "Known For Department: "
    static let genderText = "Gender: "
    static let popularityText = "Popularity: "
    static let genreText = "Genre: "
    static let womanText = "Woman"
    static let manText = "Man"
    static let tmdbAppNameText = "TMDbApp"
    static let movieDetailText = "Movie Details"
    static let personDetailText = "Person Details"
    static let onlyDateFormat = "yyyy-MM-dd"
    static let withMonthDateFormat = "MMM dd yyyy"
    static let searchBarAllScopeText = "All"
    static let searchBarTitleScopeText = "Title"
    static let searchBarGenreScopeText = "Genre"
    static let searchBarActorScopeText = "Actor"
    static let firstChangableColor = UIColor(red: 169/255, green: 62/255, blue: 152/255, alpha: 1).cgColor
    static let secondChangableColor = UIColor(red: 30/255, green: 40/255, blue: 50/255, alpha: 1).cgColor
}

struct APIUrl {
    
    let popularMovieUrl = APIParams.movieBaseUrl + APIParams.popularMovie + APIParams.keyToken + APIParams.apiKey + APIParams.otherParam
    let creditsUrl = APIParams.credits + APIParams.keyToken + APIParams.apiKey + APIParams.otherParam
}
