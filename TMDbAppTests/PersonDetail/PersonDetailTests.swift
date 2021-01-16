//
//  PersonDetailTests.swift
//  TMDbAppTests
//
//  Created by Cem Kazım on 16.01.2021.
//

@testable import TMDbApp
import XCTest
import TMDbComponents
import TMDbUtilities

class PersonDetailTests: XCTestCase {
    
    var personDetailViewController: PersonDetailViewController?
    
    override func setUp() {
        super.setUp()
        personDetailViewController = PersonDetailViewController()
    }
    
    func testingConstraints() {
        XCTAssertEqual(personDetailViewController?.personImageView.frame.width, 200.0)
    }
}
