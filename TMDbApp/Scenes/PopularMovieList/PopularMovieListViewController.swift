//
//  PopularMovieListViewController.swift
//  TMDbApp
//
//  Created by Cem Kazım on 26.12.2020.
//

import UIKit
import SDWebImage

class PopularMovieListViewController: UIViewController, PopularMovieListViewModelDelegate {
    
    // MARK: - Properties -
    
    lazy var movieTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PopularMovieListTableViewCell.self, forCellReuseIdentifier: CellIdentifiers.popularMovieListTableViewCellId)
        tableView.backgroundColor = .clear
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
        searchController.searchBar.placeholder = ConstantTexts.searchText
        searchController.searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        searchController.searchBar.setValue(ConstantTexts.cancelButtonText, forKey: ConstantTexts.cancelButtonTextId)
        return searchController
    }()
    lazy var loaderActivityIndicatorView: UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView(style: .whiteLarge)
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        return indicatorView
    }()
    lazy var popularMovieListViewModel: PopularMovieListViewModel = {
        let viewModel = PopularMovieListViewModel()
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
        updateBackgroundColor(view, CustomColors.firstChangableColor, CustomColors.secondChangableColor)
        navigationItem.title = ConstantTexts.popularMoviesText
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
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
                
                loaderActivityIndicatorView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
                loaderActivityIndicatorView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
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
    
    func setMovieList(_ movieList: [MovieModel]) {
        popularMovieListViewModel.movieList = movieList
        movieTableView.reloadData()
        loaderActivityIndicatorView.stopAnimating()
    }
    
    func getCellData(with movieList: MovieModel, cell: PopularMovieListTableViewCell) {
        cell.movieNameLabel.text = movieList.title
        cell.movieImageView.sd_setImage(with: URL(string: movieList.imageUrl ?? ""))
        cell.movieReleaseDateLabel.text = "\(ConstantTexts.releaseDateText)\(movieList.releaseDate ?? "")"
    }
}

// MARK: - MovieListViewController: UITableViewDelegate, UITableViewDataSource -

extension PopularMovieListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if movieSearchController.isActive {
            return popularMovieListViewModel.filteredMovieList.count
        } else {
            return popularMovieListViewModel.movieList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.popularMovieListTableViewCellId) as? PopularMovieListTableViewCell {
            if movieSearchController.isActive {
                getCellData(with: popularMovieListViewModel.filteredMovieList[indexPath.row], cell: cell)
            } else {
                getCellData(with: popularMovieListViewModel.movieList[indexPath.row], cell: cell)
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
        let movieDetailViewModel = MovieDetailViewModel(movieResults: popularMovieListViewModel.movieResults[indexPath.row])
        movieDetailViewController.movieDetailViewModel = movieDetailViewModel
        pushTo(movieDetailViewController)
    }
}

// MARK: - MovieListViewController: UISearchBarDelegate, UISearchResultsUpdating -

extension PopularMovieListViewController: UISearchBarDelegate, UISearchResultsUpdating {
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        // code was here...
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        popularMovieListViewModel.filteredMovieList.removeAll(keepingCapacity: false)
        if let searchTerm = searchController.searchBar.text {
            let filteredArray = popularMovieListViewModel.movieList.filter { result in
                return (result.title?.lowercased().contains(searchTerm.lowercased()) ?? false)
            }
            popularMovieListViewModel.filteredMovieList = filteredArray
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
