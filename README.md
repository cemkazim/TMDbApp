# TMDbApp

TMDbApp is a mobile app (iOS) that uses the themoviedb.org API. It is written with Swift 5.

## Usage Information

#### Popular Movie List Screen
Popular movies are listed on the home screen. A movie can be searched by text input on this screen.

<img src="https://i.ibb.co/7KgYb1q/first.jpg" width="200" height="433">

#### Movie Detail Screen
This screen is contained movie and cast details.

<img src="https://i.ibb.co/fqczFJn/second.jpg" width="200" height="433">

#### Person Detail Screen
It contains information about the actors in the movie.

<img src="https://i.ibb.co/HKqmX9W/simulator-screenshot-BBEBA651-843-E-4860-9554-B704-FD38-BBB3.png" width="200" height="433">

## Principles

- Developed without the use of Storyboard. Programmatic components were used instead. In this way, it has reached a structure that can be readable, reusable and codable.
- Integrated Alamofire and RxSwift for API queries.
- Added SDWebImage for asynchronous images.
- It is written MVVM architecture.
- Unit test cases are written for the project classes.
- Separated Network Service, View Components and Utilities from project and moved to various frameworks.
