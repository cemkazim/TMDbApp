//
//  Constants.swift
//  TMDbApp
//
//  Created by Cem Kazım on 16.01.2021.
//

import UIKit

struct CellIdentifiers {
    
    static let movieDetailCollectionViewCellId = "MovieDetailCollectionViewCell"
    static let popularMovieListTableViewCellId = "PopularMovieListTableViewCell"
}

struct ConstantTexts {
    
    static let initCoderText = "init(coder:) has not been implemented"
    static let searchText = "Search"
    static let cancelButtonText = "Cancel"
    static let cancelButtonTextId = "cancelButtonText"
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
    static let unknownText = "Unkwown"
    static let womanText = "Woman"
    static let manText = "Man"
    static let popularMoviesText = "Popular Movies"
    static let movieDetailText = "Movie Detail"
    static let personDetailText = "Person Detail"
}

struct DateFormats {
    
    static let onlyDateFormat = "yyyy-MM-dd"
    static let withMonthDateFormat = "MMM dd yyyy"
    static let birthOfChrist = "00.00.0000"
}

struct ImageNames {
    
    static let placeholder = "placeholder"
    static let placeholderProfile = "placeholder_profile"
}

struct CustomColors {
    
    static let firstChangableColor = UIColor(red: 169/255, green: 62/255, blue: 152/255, alpha: 1).cgColor
    static let secondChangableColor = UIColor(red: 30/255, green: 40/255, blue: 50/255, alpha: 1).cgColor
}

struct AlertContents {
    
    static let errorTitle = "Error"
    static let errorSubtitle = "This request is failed."
}
