# TMDbApp

TMDbApp is a mobile app (iOS) that uses the themoviedb.org API. It is written with Swift 5.

## Usage Information

#### Movie List Screen
Popular movies are listed on the home screen. A movie can be searched by text input on this screen.

![Alt text](https://ibb.co/ScFF1BR "Movie List Screen")

#### Movie Detail Screen
This screen is contained movie and cast details.

![Alt text](https://ibb.co/whcZ1kF "Movie Detail Screen")

#### Person Detail Screen
It contains information about the actors in the movie.

![Alt text](https://ibb.co/tszPTsy "Person Detail Screen")

## Principles

- Developed without the use of Storyboard. Programmatic components were used instead. In this way, it has reached a structure that can be readable, reusable and codable.
- Alamofire integrated for API queries.
- SDWebImage integrated for asynchronous images.
- It is written MVVM architecture.
- Unit test cases are written for the project classes.
- Network Service, View Components and Utilities are seperated from project.
