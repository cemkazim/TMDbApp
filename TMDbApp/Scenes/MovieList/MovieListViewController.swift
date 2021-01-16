//
//  MovieListViewController.swift
//  TMDbApp
//
//  Created by Cem Kazım on 26.12.2020.
//

import UIKit
import SDWebImage
import TMDbNetworkService
import TMDbUtilities
import TMDbComponents

class MovieListViewController: UIViewController, MovieListViewModelDelegate {
    
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
    lazy var movieSearchController: UISearchController = {
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
    
    // MARK: - View Model Property -
    
    lazy var movieListViewModel: MovieListViewModel = {
        let viewModel = MovieListViewModel()
        viewModel.delegate = self
        return viewModel
    }()
    
    // MARK: - Lifecycles -

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK: - Methods -
    
    
    func setupSearchController() {
        if #available(iOS 11.0, *) {
            navigationItem.hidesSearchBarWhenScrolling = false
            navigationItem.searchController = movieSearchController
        } else {
            movieSearchController.hidesNavigationBarDuringPresentation = false
            navigationItem.titleView = movieSearchController.searchBar
        }
    }
    
    func setupView() {
        updateBackgroundColor(view, ConstantValue.firstChangableColor, ConstantValue.secondChangableColor)
        navigationItem.title = ConstantValue.tmdbAppNameText
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        let cancelButtonAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        UIBarButtonItem.appearance().setTitleTextAttributes(cancelButtonAttributes , for: .normal)
        view.addSubview(movieTableView)
        view.addSubview(loaderActivityIndicatorView)
        loaderActivityIndicatorView.startAnimating()
        setupConstraints()
        setupSearchController()
        removeNavigationBar()
    }
    
    func setupConstraints() {
        if #available(iOS 11.0, *) {
            NSLayoutConstraint.activate([
                movieTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
                movieTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
                movieTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
                movieTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
                
                loaderActivityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                loaderActivityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
        } else {
            NSLayoutConstraint.activate([
                movieTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
                movieTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
                movieTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
                movieTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
                
                loaderActivityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                loaderActivityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
        }
    }
    
    func getMovieModelList(_ movieModelList: [MovieModel]) {
        movieListViewModel.movieModelList = movieModelList
        movieTableView.reloadData()
        loaderActivityIndicatorView.stopAnimating()
    }
}

// MARK: - MovieListViewController: UITableViewDelegate, UITableViewDataSource -

extension MovieListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if movieSearchController.isActive {
            return movieListViewModel.filteredMovieModelList.count
        } else {
            return movieListViewModel.movieModelList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: ConstantValue.movieListTableViewCellId) as? MovieListTableViewCell {
            let imageUrl = URL(string: movieListViewModel.movieModelList[indexPath.row].imageUrl ?? "")
            let releaseDate = "\(ConstantValue.releaseDateText)\(movieListViewModel.movieModelList[indexPath.row].releaseDate ?? "")"
            cell.movieImageView.sd_setImage(with: imageUrl, completed: nil)
            cell.movieReleaseDateLabel.text = releaseDate
            if movieSearchController.isActive {
                cell.movieNameLabel.text = movieListViewModel.filteredMovieModelList[indexPath.row].title
            } else {
                cell.movieNameLabel.text = movieListViewModel.movieModelList[indexPath.row].title
            }
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
        let movieDetailViewModel = MovieDetailViewModel(movieResultModel: movieListViewModel.movieResults[indexPath.row])
        movieDetailViewController.movieDetailViewModel = movieDetailViewModel
        pushTo(movieDetailViewController)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, 0, -20, 0)
        cell.layer.transform = rotationTransform
        cell.alpha = 0
        UIView.animate(withDuration: 0.75) {
            cell.layer.transform = CATransform3DIdentity
            cell.alpha = 1
        }
    }
}

// MARK: - MovieListViewController: UISearchBarDelegate, UISearchResultsUpdating -

extension MovieListViewController: UISearchBarDelegate, UISearchResultsUpdating {
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        // code was here...
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        movieListViewModel.filteredMovieModelList.removeAll(keepingCapacity: false)
        if let searchTerm = searchController.searchBar.text {
            let filteredArray = movieListViewModel.movieModelList.filter { result in
                return (result.title?.lowercased().contains(searchTerm.lowercased()) ?? false)
            }
            movieListViewModel.filteredMovieModelList = filteredArray
            if !searchController.isBeingDismissed {
                movieTableView.reloadData()
            }
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        movieSearchController.searchBar.endEditing(true)
        movieTableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        movieSearchController.isActive = false
        movieSearchController.searchBar.endEditing(true)
        movieSearchController.searchBar.showsCancelButton = false
        movieTableView.reloadData()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        movieSearchController.isActive = false
        movieSearchController.searchBar.showsCancelButton = true
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        movieSearchController.isActive = true
        movieSearchController.searchBar.showsCancelButton = true
        movieTableView.reloadData()
    }
}
