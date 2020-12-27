//
//  MovieListViewController.swift
//  TMDbApp
//
//  Created by Cem Kazım on 26.12.2020.
//

import UIKit
import SDWebImage

@available(iOS 11.0, *)
class MovieListViewController: UIViewController {
    
    // MARK: - UI Objects -
    
    lazy var movieTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MovieListTableViewCell.self, forCellReuseIdentifier: ConstantValue.movieListTableViewCellId)
        tableView.backgroundColor = UIColor.clear
        return tableView
    }()
    lazy var recordSearchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.sizeToFit()
        searchController.searchBar.barStyle = UIBarStyle.black
        searchController.searchBar.backgroundColor = UIColor.clear
        searchController.searchBar.isTranslucent = true
        searchController.searchBar.placeholder = ConstantValue.searchText
        searchController.searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        searchController.searchBar.setValue(ConstantValue.cancelButtonText, forKey: ConstantValue.cancelButtonTextId)
        return searchController
    }()
    lazy var loaderActivityIndicatorView: UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView(style: .whiteLarge)
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        return indicatorView
    }()
    
    // MARK: - Properties -
    
    lazy var movieViewModel: MovieViewModel = {
        let viewModel = MovieViewModel()
        return viewModel
    }()
    var movieResults = [Result]()
    var movieGenres = [MovieGenre]()
    var movieGenreList = [String]()
    
    // MARK: - Lifecycles -

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        getData()
        setupSearchController()
        removeNavigationBar()
    }
    
    func setupSearchController() {
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = recordSearchController
    }
    
    func setupView() {
        updateBackgroundColor(view, ConstantValue.firstChangableColor, ConstantValue.secondChangableColor)
        view.addSubview(movieTableView)
        view.addSubview(loaderActivityIndicatorView)
        loaderActivityIndicatorView.startAnimating()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            movieTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            movieTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            movieTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            movieTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            
            loaderActivityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loaderActivityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func getData() {
        movieViewModel.getMovieList(completionHandler: { [weak self] (results) in
            guard let strongSelf = self else { return }
            strongSelf.movieResults = results
            strongSelf.loaderActivityIndicatorView.stopAnimating()
            strongSelf.movieTableView.reloadData()
        })
    }
    
    func getMovieGenre(_ movieId: Int, _ cell: MovieListTableViewCell) {
        movieViewModel.getMovieGenre(movieId: movieId, completionHandler: { [weak self] (movieGenres) in
            guard let strongSelf = self else { return }
            strongSelf.setMovieGenreList(movieGenres)
            cell.movieGenreLabel.text = strongSelf.movieGenreList.joined(separator: ", ")
            strongSelf.movieGenreList.removeAll()
        })
    }
    
    func setMovieGenreList(_ movieGenres: [MovieGenre]) {
        for movieGenre in movieGenres {
            movieGenreList.append(movieGenre.name ?? "")
        }
    }
}

@available(iOS 11.0, *)
extension MovieListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: ConstantValue.movieListTableViewCellId) as? MovieListTableViewCell {
            let imageUrl = URL(string: movieViewModel.movieImageUrlList[indexPath.row])
            cell.backgroundColor = .clear
            cell.selectionStyle = .none
            cell.movieImageView.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
            cell.movieImageView.sd_setImage(with: imageUrl, completed: nil)
            cell.movieNameLabel.text = movieResults[indexPath.row].title
            getMovieGenre(movieResults[indexPath.row].id ?? 0, cell)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movieDetailViewController = MovieDetailViewController()
        if let movieId = movieResults[indexPath.row].id,
           let movieName = movieResults[indexPath.row].title,
           let movieImageUrl = URL(string: movieViewModel.movieImageUrlList[indexPath.row]),
           let overview = movieResults[indexPath.row].overview {
            let movieDetailModel = MovieDetailModel(movieId: movieId, movieName: movieName, movieImageUrl: movieImageUrl, overview: overview)
            movieDetailViewController.movieDetailModel = movieDetailModel
        }
        pushTo(movieDetailViewController)
    }
}

@available(iOS 11.0, *)
extension MovieListViewController: UISearchBarDelegate, UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
//        myRecordsViewModel.filteredMyRecordsList.removeAll(keepingCapacity: false)
//        if let searchTerm = searchController.searchBar.text {
//            let filteredArray = myRecordsViewModel.myRecordsList.filter { result in
//                return result.recordName.lowercased().contains(searchTerm.lowercased())
//            }
//            myRecordsViewModel.filteredMyRecordsList = filteredArray
//            if !searchController.isBeingDismissed {
//                myRecordsTableView.reloadData()
//            }
//        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        recordSearchController.searchBar.endEditing(true)
        movieTableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        recordSearchController.isActive = false
        recordSearchController.searchBar.endEditing(true)
        recordSearchController.searchBar.showsCancelButton = false
        movieTableView.reloadData()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        recordSearchController.isActive = false
        recordSearchController.searchBar.showsCancelButton = true
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        recordSearchController.isActive = true
        recordSearchController.searchBar.showsCancelButton = true
        movieTableView.reloadData()
    }
}
