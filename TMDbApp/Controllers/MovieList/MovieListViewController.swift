//
//  MovieListViewController.swift
//  TMDbApp
//
//  Created by Cem Kazım on 26.12.2020.
//

import UIKit
import SDWebImage

class MovieListViewController: UIViewController {
    
    // MARK : - UI Objects -
    
    lazy var movieTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MovieListTableViewCell.self, forCellReuseIdentifier: ConstantValue.movieListTableViewCellId)
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
        let indicatorView = UIActivityIndicatorView(style: .large)
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        return indicatorView
    }()
    
    // MARK: - Properties -
    
    lazy var movieViewModel: MovieViewModel = {
        let viewModel = MovieViewModel()
        return viewModel
    }()
    var movieResults = [Result]()
    
    // MARK: - Lifecycles -

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        setupSearchController()
    }
    
    func setupSearchController() {
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = recordSearchController
    }
    
    func setupView() {
        view.addSubview(movieTableView)
        view.addSubview(loaderActivityIndicatorView)
        loaderActivityIndicatorView.startAnimating()
        movieViewModel.getMovieList(completionHandler: { [weak self] (results) in
            guard let strongSelf = self else { return }
            strongSelf.movieResults = results
            strongSelf.movieTableView.reloadData()
            strongSelf.loaderActivityIndicatorView.stopAnimating()
        })
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
    
    func getMoviePopularity(_ movie: Result) -> String {
        return "Popularity: \(String(format: "%.3f", movie.popularity ?? 0.0))"
    }
}

extension MovieListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: ConstantValue.movieListTableViewCellId) as? MovieListTableViewCell {
            let imageUrl = URL(string: movieViewModel.movieImageUrlList[indexPath.row])
            cell.movieImageView.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
            cell.movieImageView.sd_setImage(with: imageUrl, completed: nil)
            cell.movieNameLabel.text = movieResults[indexPath.row].title
            cell.moviePopularityLabel.text = getMoviePopularity(movieResults[indexPath.row])
            return cell
        } else {
            return UITableViewCell()
        }
    }
}

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
