# TMDbApp

TMDbApp is a mobile app (iOS) that uses the themoviedb.org API. It is written with Swift 5.

## Usage Information

#### Movie List Screen
Popular movies are listed on the home screen. A movie can be searched by text input on this screen.

<img src="https://i.ibb.co/7KgYb1q/first.jpg" width="200" height="433">

#### Movie Detail Screen
This screen is contained movie and cast details.

<img src="https://i.ibb.co/fqczFJn/second.jpg" width="200" height="433">

#### Person Detail Screen
It contains information about the actors in the movie.

<img src="https://i.ibb.co/MCcg0Qr/third.jpg" width="200" height="433">

## Principles

- Developed without the use of Storyboard. Programmatic components were used instead. In this way, it has reached a structure that can be readable, reusable and codable.
- Alamofire integrated for API queries.
- SDWebImage integrated for asynchronous images.
- It is written MVVM architecture.
- Unit test cases are written for the project classes.
- Network Service, View Components and Utilities are seperated from project.
