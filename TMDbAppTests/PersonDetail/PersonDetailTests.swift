//
//  PersonDetailTests.swift
//  TMDbAppTests
//
//  Created by Cem Kazım on 16.01.2021.
//

@testable import TMDbApp
import XCTest

class PersonDetailTests: XCTestCase {
    
    var personDetailViewController: PersonDetailViewController?
    
    override func setUp() {
        super.setUp()
        personDetailViewController = PersonDetailViewController()
    }
    
    func testing_get_data() {
        let movieCastModel = MovieCastModel(name: "Gal Gadot", character: "Diana Prince / Wonder Woman", knownForDepartment: "Acting", profilePath: "/xu1l9WmNY1XYZyJ3M2gvGqCCDGS.jpg", gender: 1, popularity: 39.554)
        personDetailViewController?.getDataFrom(movieCastModel)
        XCTAssertNotNil(personDetailViewController?.personNameLabel.text)
        XCTAssertNotNil(personDetailViewController?.personImageView)
        XCTAssertNotNil(personDetailViewController?.personCharacterLabel.text)
        XCTAssertNotNil(personDetailViewController?.personKnownForDepartmentLabel.text)
        XCTAssertNotNil(personDetailViewController?.personGenderLabel.text)
        XCTAssertNotNil(personDetailViewController?.personPopularityLabel.text)
    }
}
